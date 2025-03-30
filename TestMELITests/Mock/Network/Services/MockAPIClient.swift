//
//  MockAPIClient.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

final class MockAPIClient: APIClientProtocol {
    
    var requestedEndpoint: String?
    var shouldReturnError = false
    var didCallCancelRequest = false
    let mockProduct: Decodable
    
    init(mockProduct: MockProductData) {
        self.mockProduct = mockProduct.getMockData()
    }

    func request<T: Decodable>(endpoint: String, method: HTTPMethod, body: [String : Any]?, requiresAuth: Bool, completion: @escaping (Result<T, APIError>) -> Void) {
        self.requestedEndpoint = endpoint
        
        if shouldReturnError {
            completion(.failure(.invalidResponse))
        } else {
            if let response = mockProduct as? T {
                completion(.success(response))
            } else {
                completion(.failure(.decodingError))
            }
        }
    }
    
    func cancelRequest() {
        didCallCancelRequest = true
    }
}
