//
//  SplashView.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol SplashViewProtocol: AnyObject {
    func animationCompletion()
}

class SplashView: UIView {
    
    weak var delegate: SplashViewProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Meli"
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Layout

extension SplashView: UIConfigurations {
    
    func setupConfigurations() {
        self.backgroundColor = TestMELIColors().getColor(.amarelo)
        fadeIn()
    }
    
    func setupHierarchy() {
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension SplashView {
    
    private func fadeIn() {
        UIView.animate(withDuration: 1.5, delay: 0.2, options: [.curveEaseIn], animations: {
            self.titleLabel.alpha = 1.0
        }, completion: { [unowned self] finished in
            if finished {
                self.delegate?.animationCompletion()
            }
        })
    }
}
