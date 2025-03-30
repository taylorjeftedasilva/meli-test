//
//  DetailProductViewControllerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class DetailProductViewControllerTests: XCTestCase {
    
    func testViewDidLoad_CallsSetupMethods() {
        let (sut, _) = makeSut()
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.view)
    }
    
    func testFetchProduct_Success() {
        let (_, mockViewModel) = makeSut()
        let mockProduct = DetailProductResponse(id: 1,
                                                title: "teste",
                                                description: "",
                                                category: "",
                                                price: 100,
                                                thumbnail: "")
        mockViewModel.data.value = .success(mockProduct)
        switch mockViewModel.data.value {
        case .success(let result):
            XCTAssertEqual(mockProduct.id, result.id)
        default:
            XCTFail()
        }
    }
    
    func testFetchProduct_Failure_ShowsError() {
        let (sut, mockViewModel) = makeSut()
        let mockError = APIError.invalidResponse
        let mockDelegate = MockDetailProductCoordinator()
        sut.delegate = mockDelegate
        
        mockViewModel.data.value = .failure(mockError)
        switch mockViewModel.data.value {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
        default:
            XCTFail()
        }
    }
    
    func testFetchProduct_LoadingState() {
        let (_, mockViewModel) = makeSut()
        mockViewModel.data.value = .loading(true)
        mockViewModel.data.value = .loading(false)
        switch mockViewModel.data.value {
        case .loading(let loading):
            XCTAssertEqual(loading, false)
        default:
            XCTFail()
        }
    }
    
    func testBackButtonTapped_CallsCancelFetchAndPopsViewController() {
        let (sut, mockViewModel) = makeSut()
        let mockNavigationController = MockNavigationController()
        mockNavigationController.viewControllers = [sut]
        sut.backButtonTapped()
        XCTAssertTrue(mockViewModel.didCancelFetch)
        XCTAssertTrue(mockNavigationController.didPopViewController)
        mockNavigationController.viewControllers = []
    }
}

// MARK: - Helpers
extension DetailProductViewControllerTests {
    private func makeSut() -> (DetailProductViewController, MockDetailProductViewModel) {
        let mockViewModel = MockDetailProductViewModel()
        let mockNavigationController = MockNavigationController()
        let mockConfiguration = MockCoordinatorConfiguration(navigationController: mockNavigationController)
        let coordinator = DetailProductCoordinator(with: mockConfiguration)
        let sut = DetailProductViewController(coordinator: coordinator, viewModel: mockViewModel)
        return (sut, mockViewModel)
    }
}

// MARK: - Mocks
class MockDetailProductViewModel: DetailProductViewModelProtocol {
    var data: Bindable<Response<DetailProductResponse>> = Bindable(value: .loading(false))
    var didCancelFetch = false
    
    func fetchProduct() {
        data.value = .loading(true)
    }
    
    func cancelFetch() {
        didCancelFetch = true
    }
}

class MockDetailProductCoordinator: DetailProductCoordinatorProtocol {
    var didShowError = false
    
    func showError(_ error: APIError, retryAgain: (() -> Void)?) {
        didShowError = true
    }
}
