//
//  ListProductControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ListProductControllerTests: XCTestCase {
    
    func testViewDidLoad_CallsSetup() {
        let (sut, _, _, _) = makeSut()
        sut.viewDidLoad()
        XCTAssertNotNil(sut.view, "A view do controlador não deveria ser nula após o viewDidLoad.")
    }
    
    func testViewWillAppear_ConfiguresNavigationController() {
        let (sut, _, _, mockNavController) = makeSut()
        sut.viewWillAppear(true)
        XCTAssertFalse(mockNavController.isNavigationBarHidden, "A navigation bar deveria estar visível.")
    }
    
    func testFetchProducts_CallsViewModelFetchProducts() {
        let (sut, viewModel, _, _) = makeSut()
        sut.fetchProdutos(isLoadMore: false)
        XCTAssertTrue(viewModel.fetchProductsCalled, "fetchProducts deveria ter sido chamado no ViewModel.")
    }
    
    func testLoadMore_CallsViewModelLoadMore() {
        let (sut, viewModel, _, _) = makeSut()
        _ = sut.loadMore()
        XCTAssertTrue(viewModel.loadMoreCalled, "loadMore deveria ter sido chamado no ViewModel.")
    }
    
    func testShowDetail_CallsDelegateShowDetail() {
        let (sut, _, mockDelegate, _) = makeSut()
        sut.showDatail(10)
        XCTAssertEqual(mockDelegate.showDetailCalledWith, 10, "showDetail deveria ter sido chamado com o ID correto.")
    }
    
    func testSearchBarSearchButtonClicked_CallsDelegateShowResultSearch() {
        let (sut, _, mockDelegate, _) = makeSut()
        let searchBar = UISearchBar()
        searchBar.text = "iPhone"
        
        sut.searchBarSearchButtonClicked(searchBar)
        XCTAssertEqual(mockDelegate.showResultSearchCalledWith, "iPhone", "showResultSearch deveria ter sido chamado com o termo de pesquisa correto.")
    }
}

// MARK: - Helpers
extension ListProductControllerTests {
    private func makeSut() -> (ListProductController, MockListProductViewModel, MockListProductCoordinator, MockNavigationController) {
        let mockViewModel = MockListProductViewModel()
        let mockWindow = UIWindow()
        let mockConfiguration = MockCoordinatorConfiguration(window: mockWindow)
        let mockDelegate = MockListProductCoordinator(with: mockConfiguration)
        let sut = ListProductController(coordinator: mockDelegate,
                                        viewModel: mockViewModel)
        let mockNavController = MockNavigationController(rootViewController: sut)
        mockWindow.rootViewController = mockNavController
        sut.delegate = mockDelegate
        checkMemoryLeak(for: mockConfiguration)
        checkMemoryLeak(for: mockWindow)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: mockDelegate)
        checkMemoryLeak(for: mockViewModel)
        return (sut, mockViewModel, mockDelegate, mockNavController)
    }
}

// MARK: - Mocks
class MockListProductCoordinator: MockBaseCoordinator, ListProductCoordinatorProtocol {
    var showDetailCalledWith: Int?
    var showResultSearchCalledWith: String?
    var showErrorCalled = false
    
    func showDetail(_ id: Int) {
        showDetailCalledWith = id
    }
    
    func showResultSearch(search: String) {
        showResultSearchCalledWith = search
    }
    
    func showError(_ error: APIError, retryAgain: (() -> Void)?) {
        showErrorCalled = true
    }
}

class MockListProductViewModel: ListProductViewModel {
    var fetchProductsCalled = false
    var loadMoreCalled = false
    
    override func fetchProducts(isLoadMore: Bool = false) {
        fetchProductsCalled = true
    }
    
    override func loadMore() -> Bool {
        loadMoreCalled = true
        return true
    }
}
