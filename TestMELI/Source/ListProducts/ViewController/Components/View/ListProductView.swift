//
//  ListProductView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import UIKit

class ListProductView: UIView {
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dataSource = ListProductDatasource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductDataSource(products:  ProductResponse) {
        dataSource.update(produtos: products)
    }
}

extension ListProductView: UIConfigurations {
    
    func setupConfigurations() {
        tableView.dataSource = dataSource
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.estimatedRowHeight = 150
    }
    
    func setupHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
}
