//
//  MockNavigationController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit

class MockNavigationController: UINavigationController {
    var didPresentAlert = false
    var didPushViewController = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        didPresentAlert = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = true
    }
}
