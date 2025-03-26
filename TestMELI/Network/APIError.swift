//
//  APIError.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

enum APIError: Error {
    case noInternetConnection
    case unauthorized
    case invalidResponse
    case decodingError
    case invalidURL
    case noData
    case unknown(Error)

    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "Sem conexão com a internet. Verifique sua conexão e tente novamente."
        case .unauthorized:
            return "Sessão expirada. Faça login novamente."
        case .invalidResponse:
            return "Resposta inválida do servidor."
        case .decodingError:
            return "Erro ao processar os dados do servidor."
        case .invalidURL:
            return "URL inválida."
        case .noData:
            return "Nenhum dado recebido do servidor."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
