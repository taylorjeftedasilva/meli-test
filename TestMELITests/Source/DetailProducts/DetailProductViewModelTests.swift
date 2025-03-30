//
//  DetailProductViewModelTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class DetailProductViewModelTests: XCTestCase {
    
    func testFetchProduct_Success() {
        let (viewModel, mockService) = makeSut()
        let mockResponse = DetailProductData(id: 1,
                                             title: "",
                                             description: "",
                                             category: "",
                                             price: 100.0,
                                             thumbnail: "")
        mockService.result = Result.success(mockResponse)
        viewModel.fetchProduct()
        
        switch viewModel.data.value {
        case .success(let response):
            XCTAssertEqual(response.id, mockResponse.id)
        default:
            XCTFail()
        }
    }
    
    func testFetchProduct_Failure() {
        let (viewModel, mockService) = makeSut()
        let mockError = APIError.invalidResponse
        
        mockService.result = Result.failure(mockError)
        viewModel.fetchProduct()
        
        switch viewModel.data.value {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
        default:
            XCTFail()
        }
    }
    
    func testCancelFetch_CallsServiceCancelRequest() {
        let (viewModel, mockService) = makeSut()
        viewModel.cancelFetch()
        
        XCTAssertTrue(mockService.didCancelRequest)
    }
}

// MARK: - Helpers
extension DetailProductViewModelTests {
    private func makeSut() -> (DetailProductViewModel, MockDetailProductService) {
        let mockService = MockDetailProductService()
        let viewModel = DetailProductViewModel(id: 1, service: mockService)
        checkMemoryLeak(for: viewModel)
        checkMemoryLeak(for: mockService)
        return (viewModel, mockService)
    }
}

// Mock do serviço
class MockDetailProductService: DetailProductServiceProtocol {
    var result: Result<DetailProductData, APIError>?
    var didCancelRequest = false
    
    func fetchProduct(productID: Int, completion: @escaping (Result<DetailProductData, APIError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
    
    func cancelRequest() {
        didCancelRequest = true
    }
}
