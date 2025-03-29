//
//  ResultSearchView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit

protocol ResultSearchViewProtocol: AnyObject {
    func showDatail(_ id: Int) -> Void
}

class ResultSearchView: UIView {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dataSource = ResultSearchDatasource()
    private let tableDelegate = ResultSearchDelegate()
    weak var delegate: ResultSearchViewProtocol? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductDataSource(products: ResultSearchResponse, search: String) {
        dataSource.update(produtos: products)
        tableDelegate.setupSearch(search: search, hasResults: products.products.count > 0)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ResultSearchView: UIConfigurations {
    
    func setupConfigurations() {
        tableView.backgroundColor = TestMELIColors().getColor(.amarelo)
        tableDelegate.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = tableDelegate
        tableView.register(ResultSearchCell.self, forCellReuseIdentifier: "ResultSearchCell")
        tableView.estimatedRowHeight = 150
    }
    
    func setupHierarchy() {
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
}

extension ResultSearchView: ResultSearchDelegateProtocol {
    func showDetailProduct(index: Int) {
        let id = dataSource.getProductID(index: index)
        delegate?.showDatail(id)
    }
}
