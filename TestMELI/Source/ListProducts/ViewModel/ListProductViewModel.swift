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
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) -> Void
}

class ListProductViewModel: ListProductViewModelProtocol {
    var data: Binding<Response<ProductResponse>> =  Binding(value: .loading(true))
    private let service: ListProductsServiceProtocol
    
    init(service: ListProductsServiceProtocol = ListProductsService()) {
        self.service = service
    }
    
    func fetchProdutos() {
        service.fetchProducts { [weak self]  result in
            switch result {
            case .success(let data):
                self?.data.value = .success(ProductResponse(data: data))
            case .failure(let error):
                self?.data.value = .failure(error)
            }
        }
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) {
        ImageLoader.shared.loadImage(from: url) { image, url in
            completion(image, url)
        }
    }
}
