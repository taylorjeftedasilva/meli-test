//
//  CoordinatorViewController.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol CoordinatedProtocol: AnyObject {
    var coordinator: CoordinatorProtocol? { get set }
}

open class CoordinatorViewController: UIViewController, CoordinatedProtocol {
    
    public var coordinator: CoordinatorProtocol?
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    public init(coordinator: CoordinatorProtocol,
                nibName: String? = nil,
                bundle: Bundle? = nil) {
        super.init(nibName: nibName, bundle: bundle)
        self.coordinator = coordinator
        setupLoadingIndicator()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupLoadingIndicator()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupLoadingIndicator()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLoadingIndicator()
    }
    
    deinit {
        coordinator?.removeCoordinator()
    }
    
    // MARK: - Loading Indicator Setup
    private func setupLoadingIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Loading Control
    public func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    public func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
