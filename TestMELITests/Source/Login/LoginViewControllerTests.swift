//
//  LoginViewControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class LoginViewControllerTests: XCTestCase {
    
    var loginViewController: LoginViewController!
    var mockViewModel: MockLoginViewModel!
    var mockWindow: UIWindow!
    var mockConfiguration: MockCoordinatorConfiguration!
    var mockCoordinator: MockBaseCoordinator!
    
    override func setUp() {
        super.setUp()
        
        mockViewModel = MockLoginViewModel()
        mockWindow = UIWindow()
        mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        mockCoordinator = MockBaseCoordinator(with: mockConfiguration)
        loginViewController = LoginViewController(coordinator: mockCoordinator, viewModel: mockViewModel)
    }
    
    override func tearDown() {
        loginViewController = nil
        mockViewModel = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func testHandleLogin_CallsViewModelHandleLogin() {
        let expectation = self.expectation(description: "handleLogin is called")
        mockViewModel.handleLogin(email: "test@example.com", password: "password") { success in
                XCTAssertTrue(self.mockViewModel.handleLoginCalled, "handleLogin deveria ser chamado")
            expectation.fulfill()
            }
        mockViewModel.simulateLoginResult(true)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHandleLogin_SuccessfulLogin() {
        let expectation = self.expectation(description: "Login success")
        loginViewController.handleLogin(emailText: "test@example.com", passwordText: "password") { success in
            XCTAssertTrue(success, "O login deveria ser bem-sucedido")
            expectation.fulfill()
        }
        mockViewModel.simulateLoginResult(true)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHandleLogin_FailedLogin() {
        let expectation = self.expectation(description: "Login failed")
        loginViewController.handleLogin(emailText: "wrong@example.com", passwordText: "wrongpassword") { success in
            XCTAssertFalse(success, "O login deveria falhar")
            expectation.fulfill()
        }
        mockViewModel.simulateLoginResult(false)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSetupUI() {
        XCTAssertNotNil(loginViewController.view, "A view não foi carregada corretamente")
        XCTAssertTrue(loginViewController.view.subviews.contains(loginViewController.view.subviews.first!), "A view de login não foi adicionada à hierarquia da view.")
    }
}
class MockLoginViewModel: LoginViewModelProtocol {
    var handleLoginCalled = false
    var completion: ((Bool) -> Void)?
    
    func handleLogin(email emailText: String?, password passwordText: String?, completion: @escaping (Bool) -> Void) {
        handleLoginCalled = true
        self.completion = completion
    }
    
    func simulateLoginResult(_ result: Bool) {
        completion?(result)
    }
}
