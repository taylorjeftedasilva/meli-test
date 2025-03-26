//
//  AuthService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

class AuthService {
    
    static let shared = AuthService()
    private let tokenManager: TokenManagerProtocol
    
    private init(tokenManager: TokenManagerProtocol = TokenManager.shared) {
        self.tokenManager = tokenManager
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: LocalizedString.baseURL.value + "auth/login") else {
            completion(false)
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
                    print("Erro de requisição:", error.localizedDescription)
                    completion(false)
                    return
                }
                
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse else {
                    print("Resposta inválida")
                    completion(false)
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    completion(false)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let accessToken = json["accessToken"] as? String,
                       let refreshToken = json["refreshToken"] as? String {
                        self.tokenManager.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch {
                    completion(false)
                }
            }.resume()
        } catch {
            completion(false)
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = tokenManager.getRefreshToken(),
              let url = URL(string: LocalizedString.baseURL.value + "refresh") else {
            completion(false)
            return
        }
        
        let body: [String: Any] = ["refreshToken": refreshToken]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String],
                   let newAccessToken = json["accessToken"],
                   let newRefreshToken = json["refreshToken"] {
                    self.tokenManager.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken)
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }.resume()
    }
}
