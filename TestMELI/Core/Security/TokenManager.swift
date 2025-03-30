//
//  TokenManager.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import Security

protocol TokenManagerProtocol {
    func saveToken(_ token: String)
    func saveTokens(accessToken: String, refreshToken: String)
    func getToken() -> String?
    func getRefreshToken() -> String?
    func clearTokens()
}

final class TokenManager {
    
    private let service = "com.example.marketplacedelivery"
    static let shared: TokenManagerProtocol = TokenManager()

    private init() {}
    
    enum TokenKeys: String {
        case accessToken = "authToken_accessToken"
        case refreshToken = "authToken_refreshToken"
    }
}

extension TokenManager {
    
    private func save(token: String, key: String) {
        
        let tokenData = Data(token.utf8)
    
        let tokenQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: tokenData
        ]
        let tokenStatus = SecItemAdd(tokenQuery as CFDictionary, nil)
        if tokenStatus != errSecSuccess {
            print("Erro ao salvar refresh token no Keychain: \(token)\(key)")
        }
    }
    
    private func clearToken(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Erro ao remover token do Keychain: \(status)")
        }
    }
}

extension TokenManager: TokenManagerProtocol {
    
    func saveToken(_ token: String) {
        let tokenData = Data(token.utf8)
        clearTokens()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: TokenKeys.accessToken.rawValue,
            kSecValueData as String: tokenData
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Erro ao salvar token no Keychain: \(status)")
        }
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        clearTokens()
        self.save(token: accessToken, key: TokenKeys.accessToken.rawValue)
        self.save(token: refreshToken, key: TokenKeys.refreshToken.rawValue)
    }
    
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: TokenKeys.accessToken.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let tokenData = item as? Data else {
            print("Erro ao buscar token no Keychain: \(status)")
            return nil
        }
        
        return String(data: tokenData, encoding: .utf8)
    }
    
    func getRefreshToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: TokenKeys.refreshToken.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let tokenData = item as? Data else {
            print("Erro ao buscar token no Keychain: \(status)")
            return nil
        }
        
        return String(data: tokenData, encoding: .utf8)
    }
    
    func clearTokens() {
        clearToken(key: TokenKeys.accessToken.rawValue)
        clearToken(key: TokenKeys.refreshToken.rawValue)
    }
}
