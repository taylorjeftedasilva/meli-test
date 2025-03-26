//
//  CoordinatorViewController.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol CoordinatedProtocol: AnyObject {
    var coordinator: CoordinatorProtocol? { get set }
}

open class CoordinatorViewController: UIViewController, CoordinatedProtocol {
    
    public var coordinator: CoordinatorProtocol?
    
    public init(coordinator: CoordinatorProtocol,
                nibName: String? = nil,
                bundle: Bundle? = nil) {
        super.init(nibName: nibName, bundle: bundle)
        self.coordinator = coordinator
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        coordinator?.removeCoordinator()
    }
}
