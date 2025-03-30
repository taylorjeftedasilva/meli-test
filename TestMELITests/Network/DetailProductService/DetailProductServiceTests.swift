//
//  DetailProductServiceTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

final class DetailProductServiceTests: XCTestCase {
    
    func testFetchProduct_Success() {
        let mockClient = MockAPIClient(mockProduct: .detail)
        let service = DetailProductService(client: mockClient)
        let expectedID = 1
        let expectation = self.expectation(description: "Fetch product success")
        
        service.fetchProduct(productID: expectedID) { result in
            switch result {
            case .success(let product):
                XCTAssertEqual(product.id, expectedID)
                XCTAssertEqual(product.title, "Produto Teste")
                XCTAssertEqual(product.description, "Descrição Teste")
                XCTAssertEqual(product.category, "Categoria Teste")
                XCTAssertEqual(product.price, 99.99)
                XCTAssertEqual(product.thumbnail, "https://image.com/teste.jpg")
            case .failure:
                XCTFail("A requisição deveria ter sido bem-sucedida.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchProduct_Failure() {
        let mockClient = MockAPIClient(mockProduct: .detail)
        mockClient.shouldReturnError = true
        let service = DetailProductService(client: mockClient)
        let expectation = self.expectation(description: "Fetch product failure")
        
        service.fetchProduct(productID: 1) { result in
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
        let mockClient = MockAPIClient(mockProduct: .detail)
        let service = DetailProductService(client: mockClient)
        
        service.cancelRequest()
        
        XCTAssertTrue(mockClient.didCallCancelRequest, "cancelRequest deveria ter sido chamado no client.")
    }
}
