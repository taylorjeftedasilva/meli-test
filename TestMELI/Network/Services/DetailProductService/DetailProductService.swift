//
//  DetailProductService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

protocol DetailProductServiceProtocol {
    func fetchProduct(productID: Int, completion: @escaping (Result<DetailProductData, APIError>) -> Void) -> URLSessionDataTask?
}

class DetailProductService: DetailProductServiceProtocol {
    private let client : APIClientProtocol
    private let entrypoint = LocalizedString.baseURL.value + "products"
    
    init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
    }
    
    func fetchProduct(productID: Int, completion: @escaping (Result<DetailProductData, APIError>) -> Void) -> URLSessionDataTask? {
        return client.request(endpoint: "\(entrypoint)/\(productID)",
                       method: .get,
                       body: nil,
                       requiresAuth: false,
                       completion: completion)
    }
}
