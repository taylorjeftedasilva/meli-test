//
//  Produto.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

struct ProductResponse: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let thumbnail: String

}

struct Dimensions: Decodable {
    let width: Double
    let height: Double
    let depth: Double
}

struct Review: Decodable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}

struct Meta: Decodable {
    let createdAt: String
    let updatedAt: String
    let barcode: String
    let qrCode: String
}
