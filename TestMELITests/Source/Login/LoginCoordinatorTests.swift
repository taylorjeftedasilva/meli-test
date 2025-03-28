//
//  LoginCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class LoginCoordinatorTests: XCTestCase {

    var loginCoordinator: LoginCoordinator!
    var mockWindow: UIWindow!
    var mockConfiguration: MockCoordinatorConfiguration!
    
    override func setUp() {
        super.setUp()
        mockWindow = UIWindow()
        mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        loginCoordinator = LoginCoordinator(with: mockConfiguration)
    }
    
    override func tearDown() {
        loginCoordinator = nil
        mockWindow = nil
        mockConfiguration = nil
        super.tearDown()
    }
    
    func testStart_ConfiguresWindowAndNavigationController() {
        loginCoordinator.start()
        XCTAssertEqual(mockWindow.rootViewController is UINavigationController, true, "A rootViewController da janela deveria ser um UINavigationController.")
        let navigationController = mockWindow.rootViewController as? UINavigationController
        XCTAssertTrue(navigationController?.topViewController is LoginViewController, "O LoginViewController deveria ser a view controller raiz do UINavigationController.")
    }
    
    func testShowAlert_PresentsAlertController() {
        let mockNavController = MockNavigationController()
        mockConfiguration.navigationController = mockNavController
        loginCoordinator.showAlert(title: "Test", message: "This is a test message")
        XCTAssertTrue(mockNavController.didPresentAlert, "Deveria apresentar o UIAlertController após a chamada de showAlert.")
    }
    
    func testShowListProducts_StartsListProductCoordinator() {
        let mockNavController = MockNavigationController()
        mockConfiguration.navigationController = mockNavController
        loginCoordinator.showListProducts()
        XCTAssertTrue(mockNavController.didPushViewController, "Deveria apresentar o ListProduct após a chamada de showListProducts.")
    }
}
