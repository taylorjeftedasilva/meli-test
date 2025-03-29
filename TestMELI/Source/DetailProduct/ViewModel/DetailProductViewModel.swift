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
    func cancelFetch() -> Void
}

class DetailProductViewModel: DetailProductViewModelProtocol {
    
    var data: Binding<Response<DetailProductResponse>> =  Binding(value: .loading(true))
    private let service: DetailProductServiceProtocol
    private var currentTask: URLSessionDataTask?
    private let detailID: Int
    
    init(id: Int, service: DetailProductServiceProtocol = DetailProductService()) {
        self.detailID = id
        self.service = service
    }
    
    func fetchProduct() {
        self.data.value = .loading(true)
        currentTask?.cancel()
        currentTask = service.fetchProduct(productID: detailID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.value = .success(DetailProductResponse(data: data))
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
}
