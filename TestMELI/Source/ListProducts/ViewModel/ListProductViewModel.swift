//
//  ListProductViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

enum Response {
    case success(ProductResponse)
    case failure(APIError)
    case loading(Bool)
}

class ListProductViewModel {
    var data: Binding<Response> =  Binding(value: .loading(true))
    private let service: ListProductsServiceProtocol
    
    init(service: ListProductsServiceProtocol = ListProductsService()) {
        self.service = service
    }
    
    func fetchProdutos() {
        service.fetchProducts { result in
            switch result {
            case .success(let data):
                self.data.value = .success(ProductResponse(data: data))
            case .failure(let error):
                self.data.value = .failure(error)
            }
        }
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) {
        ImageLoader.shared.loadImage(from: url) { image, url in
            completion(image, url)
        }
    }
}
