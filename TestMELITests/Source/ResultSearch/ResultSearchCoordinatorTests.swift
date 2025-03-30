//
//  ResultSearchCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ResultSearchCoordinatorTests: XCTestCase {
    
    func testStart_PushesResultSearchController() {
        let (_, mockNavigationController) = makeSut()
        XCTAssertTrue(mockNavigationController.didPushViewController)
    }
    
    func testShowDetail_PushesDetailProductCoordinator() {
        let (coordinator, mockNavigationController) = makeSut()
        let productId = 1
        coordinator.showDetail(productId)
        XCTAssertTrue(mockNavigationController.didPushViewController)
    }
    
    func testShowError_PresentsErrorCoordinator() {
        let (coordinator, mockNavigationController) = makeSut()
        let error = APIError.invalidResponse
        coordinator.showError(error) {
            print("Tentando novamente...")
        }
        XCTAssertTrue(mockNavigationController.didPresentAlert)
    }
}

extension ResultSearchCoordinatorTests {
    private func makeSut() -> (ResultSearchCoordinator, MockNavigationController) {
        let mockNavigationController = MockNavigationController()
        let mockConfiguration = MockCoordinatorConfiguration(navigationController: mockNavigationController)
        let coordinator = ResultSearchCoordinator(with: mockConfiguration)
        coordinator.search = ""
        checkMemoryLeak(for: mockNavigationController)
        checkMemoryLeak(for: mockConfiguration)
        checkMemoryLeak(for: coordinator)
        coordinator.start()
        return (coordinator, mockNavigationController)
    }
}
