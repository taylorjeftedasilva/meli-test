//
//  ListProductCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ListProductCoordinatorTests: XCTestCase {
    
    func testStart_PushesListProductController() {
        let (coordinator, mockNavigationController) = makeSut()
        coordinator.start()
        XCTAssertTrue(mockNavigationController.isNavigationBarHidden, "A navigation bar deve estar oculta.")
        XCTAssertTrue(mockNavigationController.didPushViewController)
    }
    
    func testShowDetail_PushesDetailProductCoordinator() {
        let (coordinator, mockNavigationController) = makeSut()
        let productId = 1
        coordinator.showDetail(productId)
        
        XCTAssertTrue(mockNavigationController.didPushViewController)
    }
    
    func testShowResultSearch_PushesResultSearchCoordinator() {
        let (coordinator, mockNavigationController) = makeSut()
        let searchQuery = "iPhone"
        coordinator.showResultSearch(search: searchQuery)
        
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

extension ListProductCoordinatorTests {
    private func makeSut() -> (ListProductCoordinator, MockNavigationController) {
        let  mockNavigationController = MockNavigationController()
        let mockConfiguration = MockCoordinatorConfiguration(navigationController: mockNavigationController)
        let coordinator = ListProductCoordinator(with: mockConfiguration)
        checkMemoryLeak(for: mockNavigationController)
        checkMemoryLeak(for: mockConfiguration)
        checkMemoryLeak(for: coordinator)
        coordinator.start()
        return (coordinator, mockNavigationController)
    }
}
