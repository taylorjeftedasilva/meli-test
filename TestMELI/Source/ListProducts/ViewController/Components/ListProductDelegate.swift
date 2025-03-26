//
//  ListProductDelegate.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import UIKit

protocol ListProductDelegateProtocol: AnyObject {
    func showDetailProduct(index: Int) -> Void
}

class ListProductDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: ListProductDelegateProtocol? = nil
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.showDetailProduct(index: indexPath.row)
    }
}
