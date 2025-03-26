//
//  APIClient.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        body: [String: Any]?,
        requiresAuth: Bool,
        completion: @escaping (Result<T, APIError>) -> Void
    )
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
    
    var value: String {
        return self.rawValue
    }
}


class APIClient: APIClientProtocol {
    
    static let shared = APIClient()
    private let tokenManager: TokenManagerProtocol
    private let authService: AuthService
    
    private init(tokenManager: TokenManagerProtocol = TokenManager.shared, authService: AuthService = AuthService.shared) {
        self.tokenManager = tokenManager
        self.authService = authService
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: [String: Any]? = nil,
        requiresAuth: Bool = true,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        if requiresAuth, let token = tokenManager.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        performRequest(request: request, completion: completion)
    }
    
    private func performRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                completion(.failure(.noInternetConnection))
                return
            }
            
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 401 {
                self.authService.refreshToken { success in
                    if success {
                        self.retryRequest(request: request, completion: completion)
                    } else {
                        completion(.failure(.unauthorized))
                    }
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    private func retryRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        var newRequest = request
        if let token = tokenManager.getToken() {
            newRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        performRequest(request: newRequest, completion: completion)
    }
}

