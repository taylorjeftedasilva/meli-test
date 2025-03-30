//
//  CoordinatorViewControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

final class CoordinatorViewControllerTests: XCTestCase {
    
    
    weak var weakCoordinator: MockCoordinator? = nil
    weak var weakViewController: CoordinatorViewController? = nil
    
    func testInitializationWithCoordinator() {
        let mockCoordinator = MockCoordinator()
        let viewController = CoordinatorViewController(coordinator: mockCoordinator)
        
        XCTAssertNotNil(viewController.coordinator)
    }
    
    func testInitializationWithoutCoordinator() {
        let viewController = CoordinatorViewController()
        
        XCTAssertNil(viewController.coordinator)
    }
    
    func testActivityIndicatorIsAddedToView() {
        let viewController = CoordinatorViewController()
        viewController.loadViewIfNeeded()
        
        let activityIndicator = viewController.view.subviews.first { $0 is UIActivityIndicatorView }
        XCTAssertNotNil(activityIndicator, "ActivityIndicatorView deveria estar na view")
    }
    
    func testStartLoading() {
        let viewController = CoordinatorViewController()
        viewController.loadViewIfNeeded()
        
        viewController.startLoading()
        let activityIndicator = viewController.view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
        
        XCTAssertTrue(activityIndicator?.isAnimating ?? false, "ActivityIndicator deveria estar animando")
        XCTAssertFalse(activityIndicator?.isHidden ?? true, "ActivityIndicator não deveria estar oculto")
    }
    
    func testStopLoading() {
        let viewController = CoordinatorViewController()
        viewController.loadViewIfNeeded()
        
        viewController.stopLoading()
        let activityIndicator = viewController.view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
        
        XCTAssertFalse(activityIndicator?.isAnimating ?? true, "ActivityIndicator não deveria estar animando")
        XCTAssertTrue(activityIndicator?.isHidden ?? false, "ActivityIndicator deveria estar oculto")
    }
}
