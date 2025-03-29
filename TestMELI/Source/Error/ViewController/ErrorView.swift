//
//  ErrorView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import UIKit

enum ErrorType {
    case generic
    case noInternet
    
    var icon: UIImage? {
        switch self {
        case .generic:
            return UIImage(systemName: "exclamationmark.triangle.fill") // Ícone de erro genérico
        case .noInternet:
            return UIImage(systemName: "wifi.slash") // Ícone de falta de internet
        }
    }
}

class ErrorView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(errorType: ErrorType, message: String) {
        super.init(frame: .zero)
        setupView()
        configure(with: errorType, message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func configure(with errorType: ErrorType, message: String) {
        imageView.image = errorType.icon
        messageLabel.text = message
    }
}
