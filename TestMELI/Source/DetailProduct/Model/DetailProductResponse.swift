//
//  DetailProductResponse.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 27/03/25.
//

struct DetailProductResponse {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let thumbnail: String
    
    init(id: Int, title: String, description: String, category: String, price: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.thumbnail = thumbnail
    }
    
    init(data: DetailProductData) {
        self.id = data.id
        self.title = data.title
        self.description = data.description
        self.category = data.category
        self.price = data.price
        self.thumbnail = data.thumbnail
    }
}
