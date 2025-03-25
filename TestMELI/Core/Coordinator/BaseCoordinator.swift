//
//  BaseCoordinator.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

open class BaseCoordinator: Coordinator {
    
    public var parentCoordinator: BaseCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var configuration: CoordinatorConfiguration
    
    public let id = UUID().uuidString
    
    public required init(with configuration: CoordinatorConfiguration,
                         parentCoordinator: BaseCoordinator? = nil) {
        self.configuration = configuration
        self.parentCoordinator = parentCoordinator
        
        self.parentCoordinator?.insertChild(childCoordinators: self)
    }
    
    open func start() {
        fatalError("Start function must be implemented by subclasses of \(String(describing: type(of: self))).")
    }
    
    public func insertChild(childCoordinators: BaseCoordinator) {
        self.childCoordinators.append(childCoordinators)
    }
}

extension BaseCoordinator: CoordinatorProtocol {
    
    public func removeCoordinator() {
        self.parentCoordinator?.childCoordinators.removeAll { $0.id == self.id }
    }
}
