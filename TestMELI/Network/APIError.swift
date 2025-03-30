//
//  APIError.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

enum APIError: Error, Equatable {
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
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.noInternetConnection, .noInternetConnection),
             (.unauthorized, .unauthorized),
             (.invalidResponse, .invalidResponse),
             (.decodingError, .decodingError),
             (.invalidURL, .invalidURL),
             (.noData, .noData):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
