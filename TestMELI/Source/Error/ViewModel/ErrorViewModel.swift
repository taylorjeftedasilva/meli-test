//
//  ErrorViewModel.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

protocol ErrorViewModelProtocol: AnyObject {
    var data: Bindable<Response<ErrorModel>> { get }
    func fetchError()
}

final class ErrorViewModel: ErrorViewModelProtocol {
    
    var errorType: APIError? = nil
    var data: Bindable<Response<ErrorModel>> = Bindable(value: .loading(true))
    
    func fetchError() {
        switch errorType {
        case .noInternetConnection:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.noInternetConnection.localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case .unauthorized:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.unauthorized.localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case .invalidResponse:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.invalidResponse.localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case .decodingError:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.decodingError.localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case .invalidURL:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.invalidURL.localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case .noData:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.noData.localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case .unknown(let error):
            let errorModel = ErrorModel(type: .noInternet,
                                        message: APIError.unknown(error).localizedDescription,
                                        showCloseButton: true)
            data.value = .success(errorModel)
        case nil:
            let errorModel = ErrorModel(type: .noInternet,
                                        message: "Algo inexperado ocorreu! Por favor, tente novamente mais tarde.",
                                        showCloseButton: true)
            data.value = .success(errorModel)
        }
    }
}
