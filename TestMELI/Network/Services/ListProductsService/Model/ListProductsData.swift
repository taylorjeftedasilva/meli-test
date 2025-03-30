//
//  ListProductsData.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

struct ListProductsData: Decodable {
    let products: [ProductData]
    let total: Int
    let skip: Int
    let limit: Int
}

struct ProductData: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let thumbnail: String
}
