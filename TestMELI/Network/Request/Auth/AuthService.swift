//
//  AuthService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

protocol AuthServiceProtocol: AnyObject {
    func login(username: String, password: String, completion: @escaping (Result<Bool, APIError>) -> Void)
    func refreshToken(completion: @escaping (Result<Bool, APIError>) -> Void)
}

class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()
    private let tokenManager: TokenManagerProtocol
    
    private init(tokenManager: TokenManagerProtocol = TokenManager.shared) {
        self.tokenManager = tokenManager
    }
    
    func login(username: String, password: String, completion: @escaping (Result<Bool, APIError>) -> Void) {
        guard let url = URL(string: LocalizedString.baseURL.value + "auth/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body: [String: Any] = ["username": username, "password": password]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    if (error as? URLError)?.code == .notConnectedToInternet {
                        completion(.failure(.noInternetConnection))
                    } else {
                        completion(.failure(.unknown(error)))
                    }
                    return
                }
                
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    completion(.failure(.unauthorized))
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let accessToken = json["accessToken"] as? String,
                       let refreshToken = json["refreshToken"] as? String {
                        self.tokenManager.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                        completion(.success(true))
                    } else {
                        completion(.failure(.invalidResponse))
                    }
                } catch _ {
                    completion(.failure(.decodingError))
                }
            }.resume()
        } catch _ {
            completion(.failure(.decodingError))
        }
    }
    
    func refreshToken(completion: @escaping (Result<Bool, APIError>) -> Void) {
        guard let refreshToken = tokenManager.getRefreshToken(),
              let url = URL(string: LocalizedString.baseURL.value + "refresh") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body: [String: Any] = ["refreshToken": refreshToken]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as? URLError)?.code == .notConnectedToInternet {
                    completion(.failure(.noInternetConnection))
                } else {
                    completion(.failure(.unknown(error)))
                }
                return
            }
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.unauthorized))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String],
                   let newAccessToken = json["accessToken"],
                   let newRefreshToken = json["refreshToken"] {
                    self.tokenManager.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken)
                    completion(.success(true))
                } else {
                    completion(.failure(.invalidResponse))
                }
            } catch _ {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
