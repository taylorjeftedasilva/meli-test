//
//  ListProductsService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

protocol ListProductsServiceProtocol {
    func fetchProducts<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void)
}

class ListProductsService: ListProductsServiceProtocol {
    private let client : APIClientProtocol
    private let entrypoint = LocalizedString.baseURL.value + "products"
    
    init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
    }
    
    func fetchProducts<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void) {
        client.request(endpoint: entrypoint,
                       method: .get,
                       body: nil,
                       requiresAuth: false,
                       completion: completion)
    }
}
