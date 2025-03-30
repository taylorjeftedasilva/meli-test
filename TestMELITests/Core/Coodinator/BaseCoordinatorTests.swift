//
//  BaseCoordinatorTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class BaseCoordinatorTests: XCTestCase {

    class MockCoordinator: BaseCoordinator {
        override func start() {
            // Implementação vazia para teste
        }
    }

    func testCoordinatorInitialization() {
        let mockConfig = MockCoordinatorConfiguration(window: UIWindow())
        let coordinator = MockCoordinator(with: mockConfig)

        XCTAssertNotNil(coordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
        XCTAssertNil(coordinator.parentCoordinator)
    }

    func testChildCoordinatorIsAddedToParent() {
        let mockConfig = MockCoordinatorConfiguration(window: UIWindow())
        let parent = MockCoordinator(with: mockConfig)
        let child = MockCoordinator(with: mockConfig, parentCoordinator: parent)

        XCTAssertTrue(parent.childCoordinators.contains { $0.id == child.id })
    }

    func testRemoveCoordinatorFromParent() {
        let mockConfig = MockCoordinatorConfiguration(window: UIWindow())
        let parent = MockCoordinator(with: mockConfig)
        let child = MockCoordinator(with: mockConfig, parentCoordinator: parent)

        XCTAssertTrue(parent.childCoordinators.contains { $0.id == child.id })

        child.removeCoordinator()
        
        XCTAssertFalse(parent.childCoordinators.contains { $0.id == child.id })
    }
}
