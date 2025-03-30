//
//  TokenManagerTests.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

class TokenManagerTests: XCTestCase {
    let tokenManager = TokenManager.shared
    let accessToken = "testAccessToken"
    let refreshToken = "testRefreshToken"
    
    override func setUp() {
        super.setUp()
        tokenManager.clearTokens()
    }
    
    override func tearDown() {
        tokenManager.clearTokens()
        super.tearDown()
    }
    
    func testSaveAndGetAccessToken() {
        tokenManager.saveToken(accessToken)
        let retrievedToken = tokenManager.getToken()
        XCTAssertEqual(retrievedToken, accessToken, "O token salvo deve ser recuperado corretamente.")
    }
    
    func testSaveAndGetRefreshToken() {
        tokenManager.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
        let retrievedRefreshToken = tokenManager.getRefreshToken()
        XCTAssertEqual(retrievedRefreshToken, refreshToken, "O refresh token salvo deve ser recuperado corretamente.")
    }
    
    func testClearTokens() {
        tokenManager.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
        tokenManager.clearTokens()
        XCTAssertNil(tokenManager.getToken(), "O token de acesso deve ser removido corretamente.")
        XCTAssertNil(tokenManager.getRefreshToken(), "O refresh token deve ser removido corretamente.")
    }
}
