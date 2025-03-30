//
//  DetailProductViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import UIKit

protocol DetailProductViewModelProtocol {
    var data: Bindable<Response<DetailProductResponse>> { get }
    func fetchProduct() -> Void
    func cancelFetch() -> Void
}

final class DetailProductViewModel: DetailProductViewModelProtocol {
    
    var data: Bindable<Response<DetailProductResponse>> =  Bindable(value: .loading(true))
    private let service: DetailProductServiceProtocol
    private let detailID: Int
    
    init(id: Int, service: DetailProductServiceProtocol = DetailProductService()) {
        self.detailID = id
        self.service = service
    }
    
    func fetchProduct() {
        self.data.value = .loading(true)
        service.cancelRequest()
        service.fetchProduct(productID: detailID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.value = .loading(false)
                self?.data.value = .success(DetailProductResponse(data: data))
            case .failure(let error):
                self?.data.value = .loading(false)
                self?.data.value = .failure(error)
            }
        }
    }
    
    func cancelFetch() {
        service.cancelRequest()
    }
}
