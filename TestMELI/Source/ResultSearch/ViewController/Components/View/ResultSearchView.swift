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
    
    func setProductDataSource(products: ResultSearchResponse) {
        dataSource.update(produtos: products)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ResultSearchView: UIConfigurations {
    
    func setupConfigurations() {
        tableDelegate.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = tableDelegate
        tableView.register(ResultSearchCell.self, forCellReuseIdentifier: "ResultSearchCell")
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

extension ResultSearchView {
    
    @objc func handleTableViewTap() {
        searchBar.endEditing(true)
        hideOverlay()
    }
}

extension ResultSearchView: UISearchBarDelegate {
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
}

extension ResultSearchView: ResultSearchDelegateProtocol {
    func showDetailProduct(index: Int) {
        let id = dataSource.getProductID(index: index)
        delegate?.showDatail(id)
    }
}
