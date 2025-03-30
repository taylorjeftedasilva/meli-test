//
//  LoginViewController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

final class LoginViewController: CoordinatorViewController {
    
    private var loginView: LoginView = LoginView()
    private let viewModel: LoginViewModelProtocol
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: LoginViewModelProtocol) {
        self.viewModel  = viewModel
        super.init(coordinator: coordinator, nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Actions
extension LoginViewController: LoginViewProtocol {
    
    func handleLogin(emailText: String?, passwordText: String?, completion: @escaping (Bool) -> Void) {
        viewModel.handleLogin(email: emailText, password: passwordText, completion: completion)
    }
}

// MARK: - Layout
extension LoginViewController: UIConfigurations {
    
    func setupConfigurations() {
        loginView.delegate = self
    }
    
    func setupHierarchy() {
        view.addSubview(loginView)
    }
    
    func setupConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loginView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
