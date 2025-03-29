//
//  ResultSearchController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit

class ResultSearchController: CoordinatorViewController {
    
    private let resultSearchView: ResultSearchView
    private let viewModel: ResultSearchViewModel
    weak var delegate: ResultSearchCoordinatorProtocol? = nil
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: ResultSearchViewModel) {
        self.viewModel  = viewModel
        self.resultSearchView = ResultSearchView()
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
extension ResultSearchController: UIConfigurations {
    
    func setupConfigurations() {
        resultSearchView.delegate = self
        viewModel.data.bind { [weak self] result in
            switch result {
            case .success(let products):
                self?.resultSearchView.setProductDataSource(products: products)
                DispatchQueue.main.async {
                    self?.stopLoading()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.showError(error)
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
        view.addSubview(resultSearchView)
    }
    
    func setupConstraints() {
        resultSearchView.translatesAutoresizingMaskIntoConstraints = false
        resultSearchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        resultSearchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        resultSearchView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultSearchView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension ResultSearchController {
    func setupNavigationController() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.isNavigationBarHidden = false
        }
    }
}

extension ResultSearchController: ResultSearchViewProtocol {
    func showDatail(_ id: Int) {
        delegate?.showDetail(id)
    }
}
