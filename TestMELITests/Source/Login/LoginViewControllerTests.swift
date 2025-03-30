//
//  LoginViewControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class LoginViewControllerTests: XCTestCase {
    
    func testHandleLogin_SuccessfulLogin() {
        let (loginViewController, mockViewModel) = makeSut()
        let expectation = self.expectation(description: "Login success")
        loginViewController.handleLogin(emailText: "test@example.com", passwordText: "password") { success in
            XCTAssertTrue(success, "O login deveria ser bem-sucedido")
            expectation.fulfill()
        }
        mockViewModel.simulateLoginResult(true)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHandleLogin_FailedLogin() {
        let (loginViewController, mockViewModel) = makeSut()
        let expectation = self.expectation(description: "Login failed")
        loginViewController.handleLogin(emailText: "wrong@example.com", passwordText: "wrongpassword") { success in
            XCTAssertFalse(success, "O login deveria falhar")
            expectation.fulfill()
        }
        mockViewModel.simulateLoginResult(false)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSetupUI() {
        let (loginViewController, _) = makeSut()
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

extension LoginViewControllerTests {
    private func makeSut() -> (LoginViewController, MockLoginViewModel) {
        let mockWindow = UIWindow()
        let mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        let mockNavController = MockNavigationController()
        let mockCoordinator = MockBaseCoordinator(with: mockConfiguration)
        let mockViewModel: MockLoginViewModel = MockLoginViewModel()
        let loginViewController = LoginViewController(coordinator: mockCoordinator, viewModel: mockViewModel)
        checkMemoryLeak(for: mockWindow)
        checkMemoryLeak(for: mockConfiguration)
        checkMemoryLeak(for: mockNavController)
        checkMemoryLeak(for: mockCoordinator)
        checkMemoryLeak(for: loginViewController)
        checkMemoryLeak(for: mockViewModel)
        return (loginViewController, mockViewModel)
    }
}
