//
//  DetailProductCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class DetailProductCoordinatorTests: XCTestCase {
    
    func testStart_WithValidProductID_PushesDetailViewController() {
        let (sut, mockNavController) = makeSut()
        sut.productID = 123
        sut.start()
        XCTAssertTrue(mockNavController.didPushViewController)
    }
    
    func testStart_WithNilProductID_DoesNotPushViewController() {
        let (sut, mockNavController) = makeSut()
        sut.start()
        XCTAssertFalse(mockNavController.didPushViewController)
    }
    
    func testShowError_PushesErrorCoordinator() {
        let (sut, mockNavController) = makeSut()
        let mockError = APIError.invalidResponse
        sut.showError(mockError, retryAgain: {})
        XCTAssertTrue(mockNavController.didPresentAlert)
    }
    
    func testPopController_PopsViewController() {
        let (sut, mockNavController) = makeSut()
        sut.productID = 123
        sut.start()
        XCTAssertTrue(mockNavController.didPushViewController)
        sut.configuration.navigationController?.popViewController(animated: false)
        XCTAssertTrue(mockNavController.didPopViewController)
    }
}

// MARK: - Helpers
extension DetailProductCoordinatorTests {
    private func makeSut() -> (DetailProductCoordinator, MockNavigationController) {
        let mockNavController = MockNavigationController()
        let mockConfiguration = MockCoordinatorConfiguration(navigationController: mockNavController)
        let sut = DetailProductCoordinator(with: mockConfiguration)
        checkMemoryLeak(for: sut)
        return (sut, mockNavController)
    }
}
