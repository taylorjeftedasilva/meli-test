//
//  ErrorViewModelTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class ErrorViewModelTests: XCTestCase {
    
    var viewModel: ErrorViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ErrorViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchError_NoInternet() {
        viewModel.errorType = .noInternetConnection
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.noInternetConnection.localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_Unauthorized() {
        viewModel.errorType = .unauthorized
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.unauthorized.localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_InvalidResponse() {
        viewModel.errorType = .invalidResponse
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.invalidResponse.localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_DecodingError() {
        viewModel.errorType = .decodingError
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.decodingError.localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_InvalidURL() {
        viewModel.errorType = .invalidURL
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.invalidURL.localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_NoData() {
        viewModel.errorType = .noData
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.noData.localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_UnknownError() {
        let unknownError = NSError(domain: "TestError", code: 999, userInfo: nil)
        viewModel.errorType = .unknown(unknownError)
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, APIError.unknown(unknownError).localizedDescription)
        XCTAssertTrue(errorModel.showCloseButton)
    }
    
    func testFetchError_NilError() {
        viewModel.errorType = nil
        viewModel.fetchError()
        
        guard case .success(let errorModel) = viewModel.data.value else {
            XCTFail("Expected success case with error model")
            return
        }
        
        XCTAssertEqual(errorModel.type, .noInternet)
        XCTAssertEqual(errorModel.message, "Algo inexperado ocorreu! Por favor, tente novamente mais tarde.")
        XCTAssertTrue(errorModel.showCloseButton)
    }
}
