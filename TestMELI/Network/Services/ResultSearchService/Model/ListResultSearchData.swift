//
//  ListResultSearchData.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

struct ListResultSearchData: Decodable {
    let products: [ResultSearchData]
    let total: Int
    let skip: Int
    let limit: Int
}

struct ResultSearchData: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let thumbnail: String
}
