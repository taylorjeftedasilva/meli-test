//
//  SplashCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation

protocol SplashViewControllerDelegate: AnyObject {
    func startLogin()
}

final class SplashCoordinator: BaseCoordinator {
    
    override func start() {
        guard let window = configuration.window else {
                    fatalError("Window não configurado no SplashCoordinator")
                }
        let splashViewController = SplashViewController(coordinator: self,
                                                        nibName: nil,
                                                        bundle: nil)
        splashViewController.delegate = self
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
    }
}

extension SplashCoordinator: SplashViewControllerDelegate {
    func startLogin() {
        let coordinator: LoginCoordinatorStarterProtocol = LoginCoordinator(with: configuration, parentCoordinator: self)
        coordinator.start()
    }
}
