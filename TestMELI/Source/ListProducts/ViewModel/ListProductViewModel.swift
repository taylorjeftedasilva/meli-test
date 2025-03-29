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
    func fetchProdutos() -> Void
    func cancelFetch() -> Void
}

class ListProductViewModel: ListProductViewModelProtocol {
    var data: Binding<Response<ProductResponse>> =  Binding(value: .loading(true))
    private var currentTask: URLSessionDataTask?
    private let service: ListProductsServiceProtocol
    
    init(service: ListProductsServiceProtocol = ListProductsService()) {
        self.service = service
    }
    
    func fetchProdutos() {
        self.data.value = .loading(true)
        currentTask?.cancel()
        currentTask = service.fetchProducts { [weak self]  result in
            switch result {
            case .success(let data):
                self?.data.value = .success(ProductResponse(data: data))
                self?.data.value = .loading(false)
            case .failure(let error):
                self?.data.value = .failure(error)
                self?.data.value = .loading(false)
            }
        }
    }
    
    func cancelFetch() {
        currentTask?.cancel()
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) {
        ImageLoader.shared.loadImage(from: url) { image, url in
            completion(image, url)
        }
    }
}
