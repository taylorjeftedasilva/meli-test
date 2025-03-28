//
//  SplashViewControllerTest.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import XCTest
@testable import TestMELI

class SplashViewControllerTests: XCTestCase {
    
    var splashViewController: SplashViewController!
    var splashCoordinator: SplashCoordinator!
    var mockDelegate: MockSplashViewControllerDelegate!
    var mockWindow: UIWindow!
    var mockConfiguration: MockCoordinatorConfiguration!
    var mockParentCoordinator: MockBaseCoordinator!
    
    override func setUp() {
        super.setUp()
        mockWindow = UIWindow()
        mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        mockParentCoordinator = MockBaseCoordinator(with: mockConfiguration)
        splashCoordinator = SplashCoordinator(with: mockConfiguration, parentCoordinator: mockParentCoordinator)
        mockDelegate = MockSplashViewControllerDelegate()
        splashViewController = SplashViewController(coordinator: splashCoordinator,
                                                    nibName: nil,
                                                    bundle: nil)
        splashViewController.delegate = mockDelegate
        _ = splashViewController.view
    }
    
    override func tearDown() {
        splashViewController = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testViewHierarchy_IsConfigured() {
        guard let splashView = getSplashView(from: splashViewController) else {
            XCTFail()
            return
        }
        XCTAssertTrue(splashViewController.view.subviews.contains(splashView), "splashView deveria estar na hierarquia de views")
    }
    
    func testAnimationCompletion_CallsStartLogin() {
        let expectation = expectation(description: "Aguardando Animacso")
        splashViewController.animationCompletion()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            XCTAssertTrue(self?.mockDelegate.didStartLogin ?? false, "startLogin() deveria ser chamado após animationCompletion()")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func getSplashView(from controller: SplashViewController) -> SplashView? {
        let mirror = Mirror(reflecting: controller)
        for child in mirror.children {
            if let view = child.value as? SplashView {
                return view
            }
        }
        return nil
    }
}

// MARK: - Mock Delegate
class MockSplashViewControllerDelegate: SplashViewControllerDelegate {
    var didStartLogin = false
    
    func startLogin() {
        didStartLogin = true
    }
}
