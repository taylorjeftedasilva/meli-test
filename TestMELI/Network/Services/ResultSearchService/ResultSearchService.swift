//
//  ResultSearchService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import Foundation

protocol ResultSearchServiceProtocol {
    func fetchProducts(search: String, completion: @escaping (Result<ListResultSearchData, APIError>) -> Void) -> URLSessionDataTask?
}

class ResultSearchService: ResultSearchServiceProtocol {
    private let client : APIClientProtocol
    private let entrypoint = LocalizedString.baseURL.value + "products"
    
    init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
    }
    
    func fetchProducts(search: String, completion: @escaping (Result<ListResultSearchData, APIError>) -> Void) -> URLSessionDataTask? {
        return client.request(endpoint: "\(entrypoint)/search?q=\(search)",
                       method: .get,
                       body: nil,
                       requiresAuth: false,
                       completion: completion)
    }
}
