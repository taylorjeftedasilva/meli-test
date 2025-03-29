//
//  ResultSearchDelegate.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit

protocol ResultSearchDelegateProtocol: AnyObject {
    func showDetailProduct(index: Int) -> Void
}

class ResultSearchDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: ResultSearchDelegateProtocol? = nil
    private var searchQuery: String = ""
    private var hasResults = false
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.showDetailProduct(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderSearchView(searchQuery: searchQuery, hasResults: hasResults)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return hasResults ? 50 : 150
    }
}

extension ResultSearchDelegate {
    
    func setupSearch(search: String, hasResults: Bool) {
        self.searchQuery = search
        self.hasResults = hasResults
    }
}
