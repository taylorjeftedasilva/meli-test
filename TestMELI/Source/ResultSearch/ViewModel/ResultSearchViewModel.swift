//
//  ResultSearchViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import Foundation
import UIKit

protocol ResultSearchViewModelProtocol {
    var data: Binding<Response<ResultSearchResponse>> { get }
    func fetchProducts() -> Void
    func getSearch() -> String
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
    
    func fetchProducts() {
        self.data.value = .loading(true)
        service.fetchProducts(search: search) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.value = .success(ResultSearchResponse(data: data))
                self?.data.value = .loading(false)
            case .failure(let error):
                self?.data.value = .failure(error)
                self?.data.value = .loading(false)
            }
        }
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?, String) -> Void) {
        ImageLoader.shared.loadImage(from: url) { image, url in
            completion(image, url)
        }
    }
    
    func getSearch() -> String {
        return self.search
    }
}
