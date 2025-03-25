//
//  LoginCoordinator.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func showAlert(title: String, message: String) -> Void
}

class LoginCoordinator: BaseCoordinator {
    
    override func start() {
        guard let window = configuration.window else {
            fatalError("Window não configurado no LoginCoordinator")
        }
        let viewModel = LoginViewModel()
        viewModel.delegate = self
        let loginViewController = LoginViewController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        configuration.navigationController = navigationController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            window.rootViewController = navigationController
        }
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        configuration.navigationController?.present(alert, animated: true)
    }
}
