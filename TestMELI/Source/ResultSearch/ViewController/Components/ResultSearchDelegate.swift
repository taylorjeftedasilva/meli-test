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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.showDetailProduct(index: indexPath.row)
    }
}
