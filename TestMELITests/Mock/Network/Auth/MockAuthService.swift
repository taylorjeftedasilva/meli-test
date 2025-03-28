//
//  MockAuthService.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit
@testable import TestMELI

class MockAuthService: AuthServiceProtocol {
    
    var loginResult: Result<Bool, APIError> = .success(true)
    
    func login(username: String, password: String, completion: @escaping (Result<Bool, APIError>) -> Void) {
        completion(loginResult)
    }
    
    func refreshToken(completion: @escaping (Result<Bool, APIError>) -> Void) {
        completion(.success(true))
    }
}
