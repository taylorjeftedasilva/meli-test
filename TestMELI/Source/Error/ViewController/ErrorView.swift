//
//  ErrorView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import UIKit

class ErrorView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tentar Novamente", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(model: ErrorModel) {
        super.init(frame: .zero)
        setupView()
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        addSubview(imageView)
        addSubview(messageLabel)
        addSubview(closeButton)
        addSubview(retryButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            
            
            // Botão de fechar
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 64),
            closeButton.heightAnchor.constraint(equalToConstant: 64),

            
            // Mensagem de erro
            messageLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 32),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            // Ícone de erro
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Botão "Tentar Novamente" flutuante
            retryButton.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 100),
            retryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            retryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            retryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
    }
    
    func configure(with model: ErrorModel) {
        imageView.image = model.type.icon
        messageLabel.text = model.message
        closeButton.isHidden = !model.showCloseButton
    }
}
