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
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Layout
extension ListProductController: UIConfigurations {
    
    func setupConfigurations() {
        viewModel.data.bind { [weak self] result in
            switch result {
            case .success(let products):
                self?.listProductsView.setProductDataSource(products: products)
            case .failure(let error):
                // Mostre um erro ou mensagem na UI
//                self?.showError(error)
                print("erro")
            case .loading(_):
                print("isloading")
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
