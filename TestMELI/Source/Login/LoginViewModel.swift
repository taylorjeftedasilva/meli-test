//
//  LoginViewModel.swift
//  TestMELI
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

protocol LoginViewModelProtocol: ObservableObject {
    var loading: Bool { get }
    var delegate: LoginCoordinatorProtocol? { get set }
    func handleLogin(email emailText: String?, password passwordText: String?) -> Void
}

final class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginCoordinatorProtocol?
    private let serviceAuth: AuthServiceProtocol
    @Published var loading: Bool = false
    
    init(delegate: LoginCoordinatorProtocol? = nil, serviceAuth: AuthServiceProtocol = AuthService.shared) {
        self.delegate = delegate
        self.serviceAuth = serviceAuth
    }
}


extension LoginViewModel {
    
    func handleLogin(email emailText: String?, password passwordText: String?) {
        guard let email = emailText, !email.isEmpty,
              let password = passwordText, !password.isEmpty else {
            delegate?.showAlert(title: "Erro", message: "Preencha todos os campos.")
            return
        }
        self.login(email, password)
    }
    
    private func login(_ email: String,_ password: String) {
        self.loading = true
        serviceAuth.login(username: email, password: password) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.delegate?.showListProducts()
                }
                self?.loading = false
            case .failure(.noInternetConnection):
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: "Sem internet!", message: "Verifique sua conexão.")
                }
                self?.loading = false
            case .failure(let error):
                let logger = Logger(subsystem: "com.testmeli.app", category: "login")
                logger.info("Erro ao tentar logar: \(error)")
                DispatchQueue.main.async {
                    self?.delegate?.showAlert(title: "Dados incorretos", message: "Por favor verifique os dados e tente novamente")
                }
                self?.loading = false
            }
        }
    }
}
