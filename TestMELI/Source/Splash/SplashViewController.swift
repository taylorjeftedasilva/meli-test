//
//  SplashViewController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit


final class SplashViewController: CoordinatorViewController {
    
    weak var delegate: SplashViewControllerDelegate?
    private let splashView = SplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SplashViewController: SplashViewProtocol {
    
    func animationCompletion() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.delegate?.startLogin()
        })
    }
}

// MARK: - Layout

extension SplashViewController: UIConfigurations {
    
    func setupHierarchy() {
        view.addSubview(splashView)
    }
    
    func setupConstraints() {
        splashView.translatesAutoresizingMaskIntoConstraints = false
        splashView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        splashView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        splashView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        splashView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupConfigurations() {
        splashView.delegate = self
    }
}
