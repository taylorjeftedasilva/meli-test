//
//  ListProductsData.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

struct DetailProductData: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let thumbnail: String
}
