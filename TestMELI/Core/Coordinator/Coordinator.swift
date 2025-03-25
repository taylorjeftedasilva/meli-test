//
//  Coordinator.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    func removeCoordinator()
}

public protocol Coordinator : AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: BaseCoordinator? { get set }
    var configuration: CoordinatorConfiguration { get set }
    var id: String { get }

    // All coordinators will be initilised with a navigation controller
    init(with configuration: CoordinatorConfiguration,
         parentCoordinator: BaseCoordinator?)

    func start()
}
