//
//  SplashCoordinatorTest.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class SplashCoordinatorTests: XCTestCase {

    func testStart_SetsRootViewController() {
        let (_, mockWindow) = makeSut()
        let expectation = expectation(description: "Aguardando Animação de Splash")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(mockWindow.rootViewController, "O rootViewController não deveria ser nulo após start()")
            XCTAssertTrue(mockWindow.rootViewController is SplashViewController, "O rootViewController deveria ser um SplashViewController")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testStartLogin_CreatesLoginCoordinator() {
        let (splashCoordinator, mockWindow) = makeSut()
        let expectation = expectation(description: "Aguardando transição para LoginViewController")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(mockWindow.rootViewController is UINavigationController, "O rootViewController deveria ser um UINavigationController após startLogin()")
            if let navController = mockWindow.rootViewController as? UINavigationController {
                XCTAssertTrue(navController.viewControllers.first is LoginViewController, "O primeiro viewController no UINavigationController deveria ser um LoginViewController")
            }
            expectation.fulfill()
        }
        
        splashCoordinator.startLogin()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

extension SplashCoordinatorTests {
    private func makeSut() -> (SplashCoordinator, UIWindow) {
        let mockWindow = UIWindow()
        let mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        let mockParentCoordinator = MockBaseCoordinator(with: mockConfiguration)
        let splashCoordinator = SplashCoordinator(with: mockConfiguration, parentCoordinator: nil)
        checkMemoryLeak(for: mockWindow)
        checkMemoryLeak(for: mockConfiguration)
        checkMemoryLeak(for: mockParentCoordinator)
        checkMemoryLeak(for: splashCoordinator)
        splashCoordinator.start()
        return (splashCoordinator, mockWindow)
    }
}
