//
//  MockProductData.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 30/03/25.
//

import XCTest
@testable import TestMELI

enum MockProductData {
    case detail
    case listProducts
    case search
    
    
    func getMockData() -> Decodable {
        switch self {
        case .detail:
            return DetailProductData(id: 1, title: "Produto Teste", description: "Descrição Teste", category: "Categoria Teste", price: 99.99, thumbnail: "https://image.com/teste.jpg")
        case .listProducts:
            return ListProductsData(products: [ProductData(id: 1, title: "Produto Teste", description: "Descrição Teste", category: "Categoria Teste", price: 99.99, thumbnail: "https://image.com/teste.jpg")],
                                    total: 1,
                                    skip: 0,
                                    limit: 20)
        case .search:
            return ListResultSearchData(products: [ResultSearchData(id: 1, title: "Produto Teste", description: "Descrição Teste", category: "Categoria Teste", price: 99.99, thumbnail: "https://image.com/teste.jpg")],
                                        total: 1,
                                        skip: 0,
                                        limit: 20)
        }
    }
}
