//
//  Produto.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

struct ProductResponse {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
    
    init(products: [Product], total: Int, skip: Int, limit: Int) {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
    
    init(data: ListProductsData) {
        self.products = data.products.map { Product(data: $0) }
        self.total = data.total
        self.skip = data.limit
        self.limit = data.limit
    }
}

struct Product {
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
    
    init(data: ProductData) {
        self.id = data.id
        self.title = data.title
        self.description = data.description
        self.category = data.category
        self.price = data.price
        self.thumbnail = data.thumbnail
    }
}
