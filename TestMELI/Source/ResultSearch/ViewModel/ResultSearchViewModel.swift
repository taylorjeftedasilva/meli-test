//
//  ResultSearchViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import Foundation
import UIKit

protocol ResultSearchViewModelProtocol {
    var data: Bindable<Response<ResultSearchResponse>> { get }
    func fetchProducts() -> Void
    func cancelFetch() -> Void
    func getSearch() -> String
}

final class ResultSearchViewModel: ResultSearchViewModelProtocol {
    
    var data: Bindable<Response<ResultSearchResponse>> =  Bindable(value: .loading(true))
    private let service: ResultSearchServiceProtocol
    private let search: String
    
    init(search: String, service: ResultSearchServiceProtocol = ResultSearchService()) {
        self.service = service
        self.search = search
    }
    
    func fetchProducts() {
        self.data.value = .loading(true)
        service.cancelRequest()
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
    
    func cancelFetch() {
        service.cancelRequest()
    }
    
    func getSearch() -> String {
        return self.search
    }
}
