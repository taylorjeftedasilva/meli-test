//
//  ListProductDelegate.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import UIKit

protocol ListProductDelegateProtocol: AnyObject {
    func showDetailProduct(index: Int) -> Void
    func fetchProdutos(isLoadMore: Bool)
    func loadMore() -> Bool
}

final class ListProductDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: ListProductDelegateProtocol? = nil
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.showDetailProduct(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let scrollViewHeight = scrollView.frame.size.height

            // Se está perto do fim e ainda há produtos para carregar
        if position > contentHeight - scrollViewHeight * 2, delegate?.loadMore() ?? false {
            delegate?.fetchProdutos(isLoadMore: true)
            }
    }
}
