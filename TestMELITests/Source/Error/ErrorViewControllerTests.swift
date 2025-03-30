//
//  ErrorViewControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ErrorViewControllerTests: XCTestCase {
    
    var sut: ErrorViewController!
    var mockCoordinator: MockErrorCoordinator!
    var configuration: MockCoordinatorConfiguration!
    var mockViewModel: MockErrorViewModel!
    
    override func setUp() {
        super.setUp()
        configuration = MockCoordinatorConfiguration(window: UIWindow())
        mockCoordinator = MockErrorCoordinator(with: configuration)
        mockViewModel = MockErrorViewModel()
        sut = ErrorViewController(coordinator: mockCoordinator, viewModel: mockViewModel)
        sut.delegate = mockCoordinator
        // Load view lifecycle
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        mockCoordinator = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func test_ViewDidLoad_ShouldSetupViewCorrectly() {
        XCTAssertNotNil(sut.view, "A view deveria estar carregada")
    }
    
    func test_TappedCloseButton_ShouldCallCloseOnDelegate() {
        sut.tappedCloseButton()
        XCTAssertTrue(mockCoordinator.didCallClose, "O método close deveria ter sido chamado no delegate")
    }
    
    func test_TappedRetryButton_ShouldCallTryAgainOnDelegate() {
        sut.tappedRetryButton()
        XCTAssertTrue(mockCoordinator.didCallTryAgain, "O método tryAgain deveria ter sido chamado no delegate")
    }
}

class MockErrorCoordinator: MockBaseCoordinator, ErrorCoordinatorProtocol {
    var didCallClose = false
    var didCallTryAgain = false
    
    func close() {
        didCallClose = true
    }
    
    func tryAgain() {
        didCallTryAgain = true
    }
}

class MockErrorViewModel: ErrorViewModelProtocol {
    var data: TestMELI.Bindable<TestMELI.Response<TestMELI.ErrorModel>> = Bindable(value: .loading(false))
    
    func fetchError() {
        self.data.value = .success(ErrorModel(type: .generic, message: "Test Error", showCloseButton: true))
    }
}
