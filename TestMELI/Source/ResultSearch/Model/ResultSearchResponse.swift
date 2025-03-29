//
//  ResultSearchProductResponse.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

struct ResultSearchResponse {
    let products: [ResultSearchProduct]
    let total: Int
    let skip: Int
    let limit: Int
    
    init(products: [ResultSearchProduct], total: Int, skip: Int, limit: Int) {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
    
    init(data: ListResultSearchData) {
        self.products = data.products.map { ResultSearchProduct(data: $0) }
        self.total = data.total
        self.skip = data.limit
        self.limit = data.limit
    }
}

struct ResultSearchProduct {
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
    
    init(data: ResultSearchData) {
        self.id = data.id
        self.title = data.title
        self.description = data.description
        self.category = data.category
        self.price = data.price
        self.thumbnail = data.thumbnail
    }
}
