//
//  AppCoordinator.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    override func start() {
        guard let window = configuration.window else {
            fatalError("Window não configurado no AppCoordinator")
        }
        let splashCoordinator = SplashCoordinator(
            with: CoordinatorConfiguration(window: window,
                                           navigationController: nil,
                                           viewController: nil,
                                           view: nil),
            parentCoordinator: self
        )
        splashCoordinator.start()
    }
}
