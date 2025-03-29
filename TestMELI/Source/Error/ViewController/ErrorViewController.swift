//
//  ErrorViewController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import UIKit

class ErrorViewController: CoordinatorViewController {
    
    private let errorView: ErrorView
    private let viewModel: ErrorViewModel
    weak var delegate: ResultSearchCoordinatorProtocol? = nil
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: ErrorViewModel) {
        self.viewModel  = viewModel
        self.errorView = ErrorView(errorType: .generic, message: "")
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
extension ErrorViewController: UIConfigurations {
//    
//    func setupConfigurations() {
//        errorView.delegate = self
//        viewModel.data.bind { [weak self] result in
//            switch result {
//            case .success(let products):
//                self?.resultSearchView.setProductDataSource(products: products)
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
//    }
    
    func setupHierarchy() {
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        errorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        errorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension ErrorViewController {
    func setupNavigationController() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.isNavigationBarHidden = false
        }
    }
}
//
//extension ResultSearchController: ResultSearchViewProtocol {
//    func showDatail(_ id: Int) {
//        delegate?.showDetail(id)
//    }
//}
