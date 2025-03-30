//
//  ListProductsService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

protocol ListProductsServiceProtocol {
    func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<ListProductsData, APIError>) -> Void)
    func cancelRequest() -> Void
}

class ListProductsService: ListProductsServiceProtocol {
    private let client : APIClientProtocol
    private let entrypoint = LocalizedString.baseURL.value + "products"
    
    init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
    }
    
    func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<ListProductsData, APIError>) -> Void) {
        client.request(endpoint: "\(entrypoint)/?limit=\(limit)&skip=\(offset)",
                       method: .get,
                       body: nil,
                       requiresAuth: false,
                       completion: completion)
    }
    
    func cancelRequest() {
        client.cancelRequest()
    }
}
