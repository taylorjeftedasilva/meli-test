//
//  ErrorCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ErrorCoordinatorTests: XCTestCase {
    
    func testStart_PresentsErrorViewController() {
        let (sut, mockNavController) = makeSut()
        sut.errorType = APIError.noData
        
        sut.start()
        
        XCTAssertTrue(mockNavController.didPresentAlert)
    }
    
    func testTryAgain_CallsTryAgainActionAndDismisses() {
        let (sut, mockNavController) = makeSut()
        var tryAgainCalled = false
        
        sut.tryAgainAction = {
            tryAgainCalled = true
        }
        
        sut.tryAgain()
        
        XCTAssertTrue(tryAgainCalled)
        XCTAssertTrue(mockNavController.dismissCalled)
    }
    
    func testClose_CallsCloseActionAndDismisses() {
        let (sut, mockNavController) = makeSut()
        var closeCalled = false
        
        sut.closeAction = {
            closeCalled = true
        }
        
        sut.close()
        
        XCTAssertTrue(closeCalled)
        XCTAssertTrue(mockNavController.dismissCalled)
    }
}

// MARK: - Helpers
extension ErrorCoordinatorTests {
    private func makeSut() -> (ErrorCoordinator, MockNavigationController) {
        let mockNavController = MockNavigationController()
        let configuration = MockCoordinatorConfiguration(navigationController: mockNavController)
        let sut = ErrorCoordinator(with: configuration)
        checkMemoryLeak(for: sut)
        return (sut, mockNavController)
    }
}
