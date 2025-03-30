//
//  CoordinatorConfigurationTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

final class CoordinatorConfigurationTests: XCTestCase {

    func testInitializationWithValidValues() {
        let window = UIWindow()
        let navigationController = UINavigationController()
        let viewController = UIViewController()
        let view = UIView()

        let config = CoordinatorConfiguration(window: window,
                                              navigationController: navigationController,
                                              viewController: viewController,
                                              view: view)

        XCTAssertNotNil(config.window)
        XCTAssertNotNil(config.navigationController)
        XCTAssertNotNil(config.viewController)
        XCTAssertNotNil(config.view)
    }

    func testInitializationWithNilValues() {
        let config = CoordinatorConfiguration(navigationController: nil,
                                              viewController: nil,
                                              view: nil)

        XCTAssertNil(config.window)
        XCTAssertNil(config.navigationController)
        XCTAssertNil(config.viewController)
        XCTAssertNil(config.view)
    }

    func testWeakReferences() {
        var navigationController: UINavigationController? = UINavigationController()
        var viewController: UIViewController? = UIViewController()
        var view: UIView? = UIView()

        let config = CoordinatorConfiguration(navigationController: navigationController,
                                              viewController: viewController,
                                              view: view)

        XCTAssertNotNil(config.navigationController)
        XCTAssertNotNil(config.viewController)
        XCTAssertNotNil(config.view)

        navigationController = nil
        viewController = nil
        view = nil

        XCTAssertNil(config.navigationController)
        XCTAssertNil(config.viewController)
        XCTAssertNil(config.view)
    }
}
