//
//  ResultSearchViewModelTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ResultSearchViewModelTests: XCTestCase {
    
    func testCancelFetch_CallsServiceCancelRequest() {
        let (viewModel, mockService) = makeSut()
        viewModel.cancelFetch()
        
        XCTAssertTrue(mockService.didCancelRequest)
    }
    
    func testGetSearch_ReturnsCorrectValue() {
        let searchQuery = "Macbook"
        let viewModel = ResultSearchViewModel(search: searchQuery, service: MockResultSearchService())
        XCTAssertEqual(viewModel.getSearch(), searchQuery)
    }
}

// MARK: - Helpers
extension ResultSearchViewModelTests {
    private func makeSut() -> (ResultSearchViewModel, MockResultSearchService) {
        let mockService = MockResultSearchService()
        let viewModel = ResultSearchViewModel(search: "iPhone", service: mockService)
        checkMemoryLeak(for: viewModel)
        checkMemoryLeak(for: mockService)
        return (viewModel, mockService)
    }
}

// Mock do serviço
class MockResultSearchService: ResultSearchServiceProtocol {

    var result: Result<ListResultSearchData, APIError>?
    var didCancelRequest = false
    
    func fetchProducts(search: String, completion: @escaping (Result<ListResultSearchData, APIError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
    
    func cancelRequest() {
        didCancelRequest = true
    }
}
