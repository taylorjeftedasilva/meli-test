//
//  ResultSearchDatasource.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit

class ResultSearchDatasource: NSObject, UITableViewDataSource {
    
    private var produtos: ResultSearchResponse? = nil
    
    func update(produtos: ResultSearchResponse) {
        self.produtos = produtos
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultSearchCell", for: indexPath) as? ResultSearchCell
        guard let product = produtos?.products[indexPath.row] else { return UITableViewCell() }
        cell?.configure(with: product)
        return cell ?? UITableViewCell()
    }
    
    func getProductID(index: Int) -> Int {
        return self.produtos?.products[index].id ?? 0
    }
}
