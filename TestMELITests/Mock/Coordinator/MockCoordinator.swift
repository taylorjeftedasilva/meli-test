//
//  MockCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit
@testable import TestMELI

class MockCoordinatorConfiguration: CoordinatorConfiguration {
    override init(window: UIWindow? = nil,
                  navigationController: UINavigationController? = nil,
                  viewController: UIViewController? = nil,
                  view: UIView? = nil) {
        super.init(window: window, navigationController: navigationController, viewController: viewController, view: view)
    }
}

class MockBaseCoordinator: BaseCoordinator {
    override func start() {
        // Mock implementation
    }
    
    override func insertChild(childCoordinators: BaseCoordinator) {
        self.childCoordinators.append(childCoordinators)
    }
}

class MockCoordinator: CoordinatorProtocol {
    var didCallRemoveCoordinator = false
    
    func removeCoordinator() {
        didCallRemoveCoordinator = true
    }
}
