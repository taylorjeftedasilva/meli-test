//
//  ListProductDatasource.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import UIKit

class ListProductDatasource: NSObject, UITableViewDataSource {
    
    private var produtos: ProductResponse? = nil
    
    func update(produtos: ProductResponse) {
        self.produtos = produtos
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        guard let product = produtos?.products[indexPath.row] else { return UITableViewCell() }
        cell?.configure(with: product)
        return cell ?? UITableViewCell()
    }
    
    func getProductID(index: Int) -> Int {
        return self.produtos?.products[index].id ?? 0
    }
}
