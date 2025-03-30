//
//  ResultSearchControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ResultSearchControllerTests: XCTestCase {
    
    func testViewDidLoad_ConfiguresView() {
        let (controller, _, mockViewModel) = makeSut()
        controller.viewDidLoad()
        XCTAssertTrue(controller.navigationItem.hidesBackButton, "A navigation item deve esconder o botão de voltar.")
        XCTAssertTrue(mockViewModel.fetchProductsCalled, "O método fetchProducts deve ser chamado ao carregar a view.")
    }
    
    func testShowDetail_CallsDelegate() {
        let (controller, _, _) = makeSut()
        let productId = 1
        let delegate = MockResultSearchCoordinator()
        controller.delegate = delegate
        controller.showDatail(productId)
        XCTAssertTrue(delegate.didCallShowDetail, "O método showDetail deve ser chamado no delegado.")
        XCTAssertEqual(delegate.receivedProductId, productId, "O ID do produto deve ser o mesmo passado no showDetail.")
    }
    
    func testBackButtonTapped_CancelsFetchAndPopsViewController() {
        let (controller, mockNavigationController, mockViewModel) = makeSut()
        controller.backButtonTapped()
        XCTAssertTrue(mockViewModel.cancelFetchCalled, "O método cancelFetch deve ser chamado ao pressionar o botão de voltar.")
        XCTAssertTrue(mockNavigationController.didPopViewController, "O método popViewController deve ser chamado ao pressionar o botão de voltar.")
        mockNavigationController.viewControllers = []
    }
}

extension ResultSearchControllerTests {
    
    private func makeSut() -> (ResultSearchController, MockNavigationController, MockResultSearchViewModel) {
        let mockNavigationController = MockNavigationController()
        let mockViewModel = MockResultSearchViewModel()
        let mockConfiguration = MockCoordinatorConfiguration(navigationController: mockNavigationController)
        let coordinator = ResultSearchCoordinator(with: mockConfiguration)
        let controller = ResultSearchController(
            coordinator: coordinator,
            viewModel: mockViewModel
        )
        mockNavigationController.viewControllers = [controller]
        _ = controller.view
        checkMemoryLeak(for: mockNavigationController)
        checkMemoryLeak(for: coordinator)
        checkMemoryLeak(for: controller)
        coordinator.start()
        return (controller, mockNavigationController, mockViewModel)
    }
}

class MockResultSearchViewModel: ResultSearchViewModelProtocol {
    
    var result: Response<ResultSearchResponse>?
    var fetchProductsCalled = false
    var cancelFetchCalled = false
    var data: Bindable<Response<ResultSearchResponse>> = Bindable(value: .loading(false))
    
    func fetchProducts() {
        fetchProductsCalled = true
        if let result = result {
            switch result {
            case .success(let products):
                self.data.value = .success(products)
            case .failure(let error):
                self.data.value = .failure(error)
            case .loading:
                break
            }
        }
    }
    
    func cancelFetch() {
        cancelFetchCalled = true
    }
    
    func getSearch() -> String {
        return "Test Search"
    }
}

class MockResultSearchCoordinator: ResultSearchCoordinatorProtocol {
    var didCallShowDetail = false
    var receivedProductId: Int?
    
    func showDetail(_ id: Int) {
        didCallShowDetail = true
        receivedProductId = id
    }
    
    func showError(_ error: APIError, retryAgain: (() -> Void)?) {
        // Simula a apresentação do erro
    }
}
