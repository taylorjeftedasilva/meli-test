//
//  LoginViewModel.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import os


struct LoginResponse: Decodable {
     let id: Int
     let accessToken: String
     let refreshToken: String
}

protocol LoginViewModelProtocol: AnyObject {
    func handleLogin(email emailText: String?, password passwordText: String?) -> Void
}

class LoginViewModel {
    
    weak var delegate: LoginCoordinatorProtocol?
}


extension LoginViewModel: LoginViewModelProtocol {
    
    func handleLogin(email emailText: String?, password passwordText: String?) {
        guard let email = emailText, !email.isEmpty,
              let password = passwordText, !password.isEmpty else {
            delegate?.showAlert(title: "Erro", message: "Preencha todos os campos.")
            return
        }
        self.login(email, password)
    }
    
    private func login(_ email: String,_ password: String) {
        let url = "https://dummyjson.com/auth/login" // URL do endpoint de login
        let parameters: [String: Any] = [
            "username": email,
            "password": password
        ]
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: LoginResponse.self) { response in
//                switch response.result {
//                case .success(let loginResponse):
//                    TokenManager.shared.saveTokens(accessToken: loginResponse.accessToken,
//                                                   refreshToken: loginResponse.refreshToken)
//                case .failure(let error):
//                    let logger = Logger(subsystem: "com.marketplacedelivery.app", category: "login")
//                    logger.error("Erro ocorrido: \(error.localizedDescription)")
//                    self.delegate?.showAlert(title: "Dados incorretos", message: "Por favor verifique os dados e tente novamente")
//                }
//            }
    }
}
