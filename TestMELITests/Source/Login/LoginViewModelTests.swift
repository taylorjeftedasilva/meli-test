//
//  LoginViewModelTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    var mockDelegate: MockLoginCoordinator!
    var mockAuthService: MockAuthService!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockLoginCoordinator()
        mockAuthService = MockAuthService()
        loginViewModel = LoginViewModel(delegate: mockDelegate, serviceAuth: mockAuthService)
    }
    
    override func tearDown() {
        loginViewModel = nil
        mockDelegate = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testHandleLogin_ShowsAlert_WhenEmailOrPasswordIsEmpty() {
        let expectation = self.expectation(description: "Alert is shown")
        loginViewModel.handleLogin(email: "", password: "", completion: { success in
            XCTAssertFalse(success, "O login não deveria ser bem-sucedido se os campos estiverem vazios.")
            XCTAssertTrue(self.mockDelegate.didShowAlert, "Deveria mostrar um alerta quando os campos estiverem vazios.")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHandleLogin_ShowsAlert_WhenNoInternetConnection() {
        mockAuthService.loginResult = .failure(.noInternetConnection)
        let expectation = self.expectation(description: "Alert is shown")
        loginViewModel.handleLogin(email: "test@example.com", password: "password", completion: { success in
            XCTAssertFalse(success, "O login não deveria ser bem-sucedido em caso de erro de conexão com a internet.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertTrue(self.mockDelegate.didShowAlert, "Deveria mostrar um alerta quando não houver conexão com a internet.")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHandleLogin_ShowsAlert_WhenCredentialsAreIncorrect() {
        mockAuthService.loginResult = .failure(.unauthorized)
        let expectation = self.expectation(description: "Alert is shown")
        loginViewModel.handleLogin(email: "wrong@example.com", password: "wrongPassword", completion: { success in
            XCTAssertFalse(success, "O login não deveria ser bem-sucedido com dados incorretos.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertTrue(self.mockDelegate.didShowAlert, "Deveria mostrar um alerta quando as credenciais estiverem incorretas.")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHandleLogin_ShowsListProducts_WhenLoginIsSuccessful() {
        mockAuthService.loginResult = .success(true)
        let expectation = self.expectation(description: "showListProducts is called")
        loginViewModel.handleLogin(email: "test@example.com", password: "password", completion: { success in
            XCTAssertTrue(success, "O login deveria ser bem-sucedido com credenciais válidas.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertTrue(self.mockDelegate.didShowListProducts, "Deveria chamar showListProducts após o login bem-sucedido.")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
}

// MARK: - Mock Classes

class MockLoginCoordinator: LoginCoordinatorProtocol {
    var didShowAlert = false
    var didShowListProducts = false
    
    func showAlert(title: String, message: String) {
        didShowAlert = true
    }
    
    func showListProducts() {
        didShowListProducts = true
    }
}
