//
//  ListProductController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import UIKit

class ListProductController: CoordinatorViewController {
    
    private let listProductsView: ListProductView
    private let viewModel: ListProductViewModel
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: ListProductViewModel) {
        self.viewModel  = viewModel
        self.listProductsView = ListProductView()
        super.init(coordinator: coordinator, nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
}

// MARK: - Layout
extension ListProductController: UIConfigurations {
    
    func setupConfigurations() {
        viewModel.data.bind { [weak self] result in
            switch result {
            case .success(let products):
                self?.listProductsView.setProductDataSource(products: products)
                DispatchQueue.main.async {
                    self?.stopLoading()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.stopLoading()
                }
            case .loading(_):
                DispatchQueue.main.async {
                    self?.startLoading()
                }
            }
        }
        self.viewModel.fetchProdutos()
    }
    
    func setupHierarchy() {
        view.addSubview(listProductsView)
    }
    
    func setupConstraints() {
        listProductsView.translatesAutoresizingMaskIntoConstraints = false
        listProductsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listProductsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listProductsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listProductsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension ListProductController {
    func setupNavigationController() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.isNavigationBarHidden = true
        }
    }
}
