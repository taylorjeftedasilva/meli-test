//
//  DetailViewController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

final class DetailProductViewController: CoordinatorViewController {
    
    private let viewModel: DetailProductViewModelProtocol
    private let detailProductView: DetailProductView = DetailProductView()
    weak var delegate: DetailProductCoordinatorProtocol? = nil
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: DetailProductViewModelProtocol) {
        self.viewModel  = viewModel
        super.init(coordinator: coordinator, nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setup()
        setupNavigationController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Layout
extension DetailProductViewController: UIConfigurations {

    func setupConfigurations() {
        viewModel.data.bind { [weak self] result in
            switch result {
            case .success(let product):
                DispatchQueue.main.async {
                    self?.detailProductView.configure(product: product)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.showError(error,
                                              retryAgain: self?.viewModel.fetchProduct)
                }
            case .loading(let loading):
                DispatchQueue.main.async {
                    loading ? self?.startLoading() : self?.stopLoading()
                }
            }
        }
        self.viewModel.fetchProduct()
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
            self?.setupNavigationControllerColor()
        }
    }
    
    @objc override func backButtonTapped() {
        viewModel.cancelFetch()
        navigationController?.popViewController(animated: true)
    }
}
