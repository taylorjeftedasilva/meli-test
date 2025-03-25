//
//  CoordinatorConfiguration.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

public class CoordinatorConfiguration {
    
    public weak var window: UIWindow?
    public weak var navigationController: UINavigationController?
    public weak var viewController: UIViewController?
    public weak var view: UIView?
    
    public init(window: UIWindow? = nil,
                navigationController: UINavigationController?,
                viewController: UIViewController?,
                view: UIView?) {
        self.window = window
        self.navigationController = navigationController
        self.viewController = viewController
        self.view = view
    }
}
