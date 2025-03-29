//
//  ListProductViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol ResultSearchViewModelProtocol {
    var data: Binding<Response<ResultSearchResponse>> { get }
    func fetchProdutos() -> Void
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) -> Void
}

class ResultSearchViewModel: ResultSearchViewModelProtocol {
    
    var data: Binding<Response<ResultSearchResponse>> =  Binding(value: .loading(true))
    private let service: ResultSearchServiceProtocol
    private let search: String
    
    init(search: String, service: ResultSearchServiceProtocol = ResultSearchService()) {
        self.service = service
        self.search = search
    }
    
    func fetchProdutos() {
        service.fetchProducts(search: search) { result in
            switch result {
            case .success(let data):
                self.data.value = .success(ResultSearchResponse(data: data))
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
