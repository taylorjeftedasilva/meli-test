//
//  DetailProductViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import UIKit

protocol DetailProductViewModelProtocol {
    var data: Binding<Response<DetailProductResponse>> { get }
    func fetchProduct() -> Void
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) -> Void
}

class DetailProductViewModel: DetailProductViewModelProtocol {
    
    var data: Binding<Response<DetailProductResponse>> =  Binding(value: .loading(true))
    
    private let service: DetailProductServiceProtocol
    private let detailID: Int
    
    init(id: Int, service: DetailProductServiceProtocol = DetailProductService()) {
        self.detailID = id
        self.service = service
    }
    
    func fetchProduct() {
        service.fetchProduct(productID: detailID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.value = .success(DetailProductResponse(data: data))
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
