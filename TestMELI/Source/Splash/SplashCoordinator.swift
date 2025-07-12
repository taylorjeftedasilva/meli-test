//
//  SplashCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import SwiftUI

protocol SplashViewControllerDelegate: AnyObject {
    func startLogin()
}

final class SplashCoordinator: BaseCoordinator {
    
    override func start() {
        guard let window = configuration.window else {
                    fatalError("Window não configurado no SplashCoordinator")
                }
        let swiftUIView = SpashViewUI(delegate: self)
        let splashViewController = UIHostingController(rootView: swiftUIView)
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
    }
}

extension SplashCoordinator: SplashViewControllerDelegate {
    func startLogin() {
        let coordinator: LoginCoordinatorStarterProtocol = LoginCoordinator(with: configuration)
        coordinator.start()
    }
}
