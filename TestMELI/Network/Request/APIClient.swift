//
//  APIClient.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation
import os

protocol APIClientProtocol {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        body: [String: Any]?,
        requiresAuth: Bool,
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> URLSessionDataTask?
    func cancelRequest() -> Void
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
    private let logger = Logger(subsystem: "com.testmeli.app", category: "Networking")
    private var currentTask: URLSessionDataTask?

    private init(tokenManager: TokenManagerProtocol = TokenManager.shared, authService: AuthService = AuthService.shared) {
        self.tokenManager = tokenManager
        self.authService = authService
    }

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: [String : Any]? = nil,
        requiresAuth: Bool = true,
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> URLSessionDataTask? {
        logger.info("Iniciando requisição para \(endpoint) com método \(method.rawValue)")
        
        guard let url = URL(string: endpoint) else {
            logger.error("Erro: URL inválida - \(endpoint)")
            completion(.failure(.invalidURL))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
                logger.info("Corpo da requisição: \(body.description)")
            } catch {
                logger.error("Erro ao serializar body: \(error.localizedDescription)")
                completion(.failure(.decodingError))
                return nil
            }
        }
        
        if requiresAuth, let token = tokenManager.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            logger.info("Token de autenticação adicionado ao header")
        }
        
        let task = performRequest(request: request, completion: completion)
        currentTask = task
        return task
    }
    
    private func performRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) -> URLSessionDataTask {
        logger.info("Enviando requisição para \(request.url?.absoluteString ?? "URL desconhecida")")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                self.logger.error("Erro: Sem conexão com a internet")
                completion(.failure(.noInternetConnection))
                return
            }
            
            if let error = error as NSError?, error.code == NSURLErrorCancelled {
                self.logger.info("Requisição cancelada")
                return
            }

            if let error = error {
                self.logger.error("Erro desconhecido: \(error.localizedDescription)")
                completion(.failure(.unknown(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.logger.error("Erro: Resposta inválida")
                completion(.failure(.invalidResponse))
                return
            }
            
            self.logger.info("Resposta recebida: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 401 {
                self.logger.warning("Token expirado, tentando refresh token...")
                self.authService.refreshToken { result in
                    switch result {
                    case .success:
                        self.logger.info("Refresh token bem-sucedido, reexecutando requisição")
                        _ = self.retryRequest(request: request, completion: completion)
                    case .failure(.noInternetConnection):
                        self.logger.error("Erro: Sem conexão durante refresh token")
                        completion(.failure(.unauthorized))
                    case .failure(let error):
                        self.logger.error("Erro ao renovar token: \(error)")
                        completion(.failure(.unauthorized))
                    }
                }
                return
            }
            
            guard let data = data else {
                self.logger.error("Erro: Nenhum dado recebido")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                self.logger.info("Resposta decodificada com sucesso")
                completion(.success(decodedResponse))
            } catch {
                self.logger.error("Erro ao decodificar JSON: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
        return task
    }
    
    private func retryRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) -> URLSessionDataTask {
        var newRequest = request
        if let token = tokenManager.getToken() {
            newRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        logger.info("Reexecutando requisição após refresh token")
        return performRequest(request: newRequest, completion: completion)
    }
    
    func cancelRequest() {
        currentTask?.cancel()
        logger.info("Requisição cancelada pelo usuário")
    }
}
