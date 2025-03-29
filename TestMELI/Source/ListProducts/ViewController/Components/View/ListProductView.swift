//
//  ListProductView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import UIKit

protocol ListProductViewProtocol: AnyObject {
    func showDatail(_ id: Int) -> Void
    func fetchProdutos(isLoadMore: Bool)
    func loadMore() -> Bool
}

class ListProductView: UIView {
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTableViewTap))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private let dataSource = ListProductDatasource()
    private let tableDelegate = ListProductDelegate()
    weak var delegate: ListProductViewProtocol? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductDataSource(products: ProductResponse) {
        dataSource.update(produtos: products)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ListProductView: UIConfigurations {
    
    func setupConfigurations() {
        tableDelegate.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = tableDelegate
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.estimatedRowHeight = 150
    }
    
    func setupHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
        self.addSubview(overlayView)
    }
    
    func setupConstraints() {
        
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        overlayView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        overlayView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}

extension ListProductView {
    
    @objc func handleTableViewTap() {
        searchBar.endEditing(true)
        hideOverlay()
    }
}

extension ListProductView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showOverlay()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideOverlay()
    }
    
    private func showOverlay() {
        overlayView.isHidden = false
    }
    
    private func hideOverlay() {
        overlayView.isHidden = true
    }
    
    func configureSearchBar(delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
}

extension ListProductView: ListProductDelegateProtocol {
    func fetchProdutos(isLoadMore: Bool) {
        delegate?.fetchProdutos(isLoadMore: isLoadMore)
    }
    
    func loadMore() -> Bool {
        delegate?.loadMore() ?? false
    }
    
    func showDetailProduct(index: Int) {
        let id = dataSource.getProductID(index: index)
        delegate?.showDatail(id)
    }
}
