//
//  ResultSearchServiceTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

final class ResultSearchServiceTests: XCTestCase {
    
    func testFetchProduct_Success() {
        let mockClient = MockAPIClient(mockProduct: .search)
        let service = ResultSearchService(client: mockClient)
        let expectation = self.expectation(description: "Fetch product success")
        
        service.fetchProducts(search: "") { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.products[0].id, 1)
                XCTAssertEqual(products.total, 1)
            case .failure:
                XCTFail("A requisição deveria ter sido bem-sucedida.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchProduct_Failure() {
        let mockClient = MockAPIClient(mockProduct: .search)
        mockClient.shouldReturnError = true
        let service = ResultSearchService(client: mockClient)
        let expectation = self.expectation(description: "Fetch product failure")
        
        service.fetchProducts(search: "") { result in
            switch result {
            case .success:
                XCTFail("A requisição deveria ter falhado.")
            case .failure(let error):
                XCTAssertEqual(error, .invalidResponse)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCancelRequest() {
        let mockClient = MockAPIClient(mockProduct: .search)
        let service = ResultSearchService(client: mockClient)
        
        service.cancelRequest()
        
        XCTAssertTrue(mockClient.didCallCancelRequest, "cancelRequest deveria ter sido chamado no client.")
    }
}
