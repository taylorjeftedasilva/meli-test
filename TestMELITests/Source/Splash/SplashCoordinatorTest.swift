//
//  SplashCoordinatorTest.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class SplashCoordinatorTests: XCTestCase {
    var splashCoordinator: SplashCoordinator!
    var mockWindow: UIWindow!
    var mockConfiguration: MockCoordinatorConfiguration!
    var mockParentCoordinator: MockBaseCoordinator!

    override func setUp() {
        super.setUp()
        mockWindow = UIWindow()
        mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        mockParentCoordinator = MockBaseCoordinator(with: mockConfiguration)
        splashCoordinator = SplashCoordinator(with: mockConfiguration, parentCoordinator: mockParentCoordinator)
    }

    func testStart_SetsRootViewController() {
        splashCoordinator.start()
        
        XCTAssertNotNil(mockWindow.rootViewController, "O rootViewController não deveria ser nulo após start()")
        XCTAssertTrue(mockWindow.rootViewController is SplashViewController, "O rootViewController deveria ser um SplashViewController")
    }
    
    func testStartLogin_CreatesLoginCoordinator() {
        let expectation = expectation(description: "Aguardando transição para LoginViewController")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.mockWindow.rootViewController is UINavigationController, "O rootViewController deveria ser um UINavigationController após startLogin()")
            if let navController = self.mockWindow.rootViewController as? UINavigationController {
                XCTAssertTrue(navController.viewControllers.first is LoginViewController, "O primeiro viewController no UINavigationController deveria ser um LoginViewController")
            }
            expectation.fulfill()
        }
        
        splashCoordinator.startLogin()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

