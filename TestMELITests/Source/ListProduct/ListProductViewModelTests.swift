//
//  ListProductViewModelTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ListProductViewModelTests: XCTestCase {
    
    let mockService = MockListProductsService()
    lazy var sut = ListProductViewModel(service: mockService)
    
    func testFetchProducts_CallsServiceFetchProducts() {
        let (sut, mockService) = makeSut()
        sut.fetchProducts()
        XCTAssertTrue(mockService.fetchProductsCalled, "fetchProducts deveria ter sido chamado no serviço.")
    }
    
    func testFetchProducts_SuccessfullyUpdatesData() {
        let produtos = [ProductData(id: 1,
                                title: "Produto Teste",
                                description: "",
                                category: "",
                                price: 0.0,
                                thumbnail: "")]
        let mockResponse = ListProductsData(products: produtos, total: 1, skip: 0, limit: 20)
        let expectation = expectation(description: "Aguardando transição para LoginViewController")
        switch sut.data.value {
        case .success(let response):
            XCTAssertEqual(response.products.count, 1, "A resposta deveria conter 1 produto.")
            XCTAssertEqual(response.products.first?.id, 1, "O ID do produto deveria ser 1.")
        case .loading(let loading):
            if !loading { expectation.fulfill() }
        default:
            XCTFail("O estado esperado era .success, mas recebeu outro.")
        }
        mockService.completeWithSuccess(mockResponse)
        sut.fetchProducts(isLoadMore: true)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchProducts_FailsAndUpdatesData() {
        let mockError = APIError.invalidResponse
        
        sut.fetchProducts()
        mockService.completeWithFailure(mockError)
        
        switch sut.data.value {
        case .failure(let error):
            XCTAssertEqual(error, mockError, "O erro retornado deveria ser APIError.invalidResponse.")
        case .loading(let loading):
            print(loading)
        default:
            XCTFail("O estado esperado era .failure, mas recebeu outro.")
        }
    }
    
    func testLoadMore_ReturnsCorrectValue() {
        let (sut, _) = makeSut()
        sut.fetchProducts()
        XCTAssertFalse(sut.loadMore(), "loadMore deveria retornar false se não há mais produtos para carregar.")
    }
    
    func testCancelFetch_CallsServiceCancelRequest() {
        let (sut, mockService) = makeSut()
        sut.cancelFetch()
        XCTAssertTrue(mockService.cancelRequestCalled, "cancelRequest deveria ter sido chamado no serviço.")
    }
}

// MARK: - Helpers
extension ListProductViewModelTests {
    private func makeSut() -> (ListProductViewModel, MockListProductsService) {
        let mockService = MockListProductsService()
        let sut = ListProductViewModel(service: mockService)
        
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: mockService)
        
        return (sut, mockService)
    }
}

// MARK: - Mocks
class MockListProductsService: ListProductsServiceProtocol {
    
    var fetchProductsCalled = false
    var cancelRequestCalled = false
    var completion: ((Result<ListProductsData, APIError>) -> Void)?
    
    func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<ListProductsData, APIError>) -> Void) {
        fetchProductsCalled = true
        self.completion = completion
    }
    
    func completeWithSuccess(_ response: ListProductsData) {
        completion?(.success(response))
    }
    
    func completeWithFailure(_ error: APIError) {
        completion?(.failure(error))
    }
    
    func cancelRequest() {
        cancelRequestCalled = true
    }
}
