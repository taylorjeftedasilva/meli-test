//
//  ListProductViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol ListProductViewModelProtocol {
    var data: Binding<Response<ProductResponse>> { get }
    func fetchProducts() -> Void
    func fetchProducts(isLoadMore: Bool) -> Void
    func loadMore() -> Bool
    func cancelFetch() -> Void
}

final class ListProductViewModel: ListProductViewModelProtocol {
    var data: Binding<Response<ProductResponse>> =  Binding(value: .loading(false))
    private let service: ListProductsServiceProtocol
    private var produtos: [Product] = []
    private var isLoading = false
    private var offset = 0
    private let limit = 20
    private var totalProdutos = 0
    
    init(service: ListProductsServiceProtocol = ListProductsService()) {
        self.service = service
    }
    
    func fetchProducts(isLoadMore: Bool = false) {
            guard !isLoading else { return }
            isLoading = true
            
            if !isLoadMore {
                data.value = .loading(true)
            }
            service.cancelRequest()
            service.fetchProducts(offset: offset, limit: limit) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let newProdutos = response.products.map { Product(data: $0) }
                        
                        if isLoadMore {
                            self.produtos.append(contentsOf: newProdutos)
                        } else {
                            self.produtos = newProdutos
                        }
                        self.offset += self.limit
                        self.totalProdutos = response.total
                        self.data.value = .success(ProductResponse(products: self.produtos, total: self.totalProdutos, skip: self.offset, limit: self.limit))
                        self.data.value = .loading(false)
                    case .failure(let error):
                        self.data.value = .failure(error)
                        self.data.value = .loading(false)
                    }
                    
                    self.isLoading = false
                }
            }
        }
    
    func fetchProducts() {
        self.fetchProducts(isLoadMore: false)
    }
    
    func cancelFetch() {
        service.cancelRequest()
    }
    
    func loadMore() -> Bool {
        offset < totalProdutos
    }
}
