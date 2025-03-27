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
    func handleLogin(email emailText: String?, password passwordText: String?, completion: @escaping (Bool) -> Void) -> Void
}

class LoginViewModel {
    
    weak var delegate: LoginCoordinatorProtocol?
}


extension LoginViewModel: LoginViewModelProtocol {
    
    func handleLogin(email emailText: String?, password passwordText: String?, completion: @escaping (Bool) -> Void) {
        guard let email = emailText, !email.isEmpty,
              let password = passwordText, !password.isEmpty else {
            delegate?.showAlert(title: "Erro", message: "Preencha todos os campos.")
            completion(false)
            return
        }
        self.login(email, password, completion: completion)
    }
    
    private func login(_ email: String,_ password: String, completion: @escaping (Bool) -> Void) {
        AuthService.shared.login(username: email, password: password) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.delegate?.showListProducts()
                }
                completion(true)
            case .failure(.noInternetConnection):
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: "Sem internet!", message: "Verifique sua conexão.")
                }
                completion(false)
            case .failure(let error):
                let logger = Logger(subsystem: "com.testmeli.app", category: "login")
                logger.info("Erro ao tentar logar: \(error)")
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: "Dados incorretos", message: "Por favor verifique os dados e tente novamente")
                }
                completion(false)
            }
        }
    }
}
