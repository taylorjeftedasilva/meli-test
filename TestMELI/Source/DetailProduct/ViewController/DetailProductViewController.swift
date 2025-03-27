//
//  DetailViewController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

class DetailProductViewController: CoordinatorViewController {
    
    private let viewModel: DetailProductViewModel
    private let detailProductView: DetailProductView = DetailProductView()
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: DetailProductViewModel) {
        self.viewModel  = viewModel
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
extension DetailProductViewController: UIConfigurations {

    func setupConfigurations() {
//        listProductsView.delegate = self
//        viewModel.data.bind { [weak self] result in
//            switch result {
//            case .success(let products):
//                self?.listProductsView.setProductDataSource(products: products)
//                DispatchQueue.main.async {
//                    self?.stopLoading()
//                }
//            case .failure(_):
//                DispatchQueue.main.async {
//                    self?.stopLoading()
//                }
//            case .loading(_):
//                DispatchQueue.main.async {
//                    self?.startLoading()
//                }
//            }
//        }
//        self.viewModel.fetchProdutos()
    }

    func setupHierarchy() {
        view.addSubview(detailProductView)
    }

    func setupConstraints() {
        detailProductView.translatesAutoresizingMaskIntoConstraints = false
        detailProductView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailProductView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailProductView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        detailProductView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension DetailProductViewController {
    func setupNavigationController() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.isNavigationBarHidden = false
            self?.navigationController?.setupNavigationControllerColor()
        }
    }
}
