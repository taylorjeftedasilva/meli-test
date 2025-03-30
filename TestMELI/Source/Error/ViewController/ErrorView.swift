//
//  ErrorView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import UIKit

protocol ErrorViewProtocol: AnyObject {
    func tappedCloseButton() -> Void
    func tappedRetryButton() -> Void
}

final class ErrorView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .red
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let closeButton: UIButton = {
        let view = UIButton(type: .system)
        if let closeImage = UIImage(systemName: "xmark.circle.fill") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 32, height: 32)).image { _ in
                closeImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)))
            }
            view.setImage(resizedImage, for: .normal)
        }
        view.tintColor = .gray
        view.isHidden = true
        view.addTarget(self, action:  #selector(tappedCloseButton), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let retryButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Tentar Novamente", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        view.addTarget(self, action:  #selector(tappedRetryButton), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: ErrorViewProtocol? = nil
    
    init(model: ErrorModel) {
        super.init(frame: .zero)
        setup()
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: UIConfigurations {
    
    func setupConfigurations() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
    }
    
    func setupHierarchy() {
        addSubview(imageView)
        addSubview(messageLabel)
        addSubview(closeButton)
        addSubview(retryButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // Botão de fechar
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32),

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

extension ErrorView {
    
    @objc func tappedCloseButton() {
        delegate?.tappedCloseButton()
    }
    
    @objc func tappedRetryButton() {
        delegate?.tappedRetryButton()
    }
}
