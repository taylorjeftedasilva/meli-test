//
//  LoginCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class LoginCoordinatorTests: XCTestCase {
    
    func testStart_ConfiguresWindowAndNavigationController() {
        let (loginCoordinator, mockWindow, _, _) = makeSut()
        loginCoordinator.start()
        XCTAssertEqual(mockWindow.rootViewController is UINavigationController, true, "A rootViewController da janela deveria ser um UINavigationController.")
        let navigationController = mockWindow.rootViewController as? UINavigationController
        XCTAssertTrue(navigationController?.topViewController is LoginViewController, "O LoginViewController deveria ser a view controller raiz do UINavigationController.")
    }
    
    func testShowAlert_PresentsAlertController() {
        let (loginCoordinator, _, mockNavController, mockConfiguration) = makeSut()
        mockConfiguration.navigationController = mockNavController
        loginCoordinator.showAlert(title: "Test", message: "This is a test message")
        XCTAssertTrue(mockNavController.didPresentAlert, "Deveria apresentar o UIAlertController após a chamada de showAlert.")
    }
    
    func testShowListProducts_StartsListProductCoordinator() {
        let (loginCoordinator, _, mockNavController, mockConfiguration) = makeSut()
        mockConfiguration.navigationController = mockNavController
        loginCoordinator.showListProducts()
        XCTAssertTrue(mockNavController.didPushViewController, "Deveria apresentar o ListProduct após a chamada de showListProducts.")
    }
}

extension LoginCoordinatorTests {
    private func makeSut() -> (LoginCoordinator, UIWindow, MockNavigationController, MockCoordinatorConfiguration) {
        let mockWindow = UIWindow()
        let mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        let mockNavController = MockNavigationController()
        let loginCoordinator = LoginCoordinator(with: mockConfiguration)
        checkMemoryLeak(for: mockWindow)
        checkMemoryLeak(for: mockConfiguration)
        checkMemoryLeak(for: loginCoordinator)
        loginCoordinator.start()
        return (loginCoordinator, mockWindow, mockNavController, mockConfiguration)
    }
}
