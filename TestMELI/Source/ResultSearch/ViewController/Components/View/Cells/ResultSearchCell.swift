//
//  ResultSearchCell.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import UIKit

final class ResultSearchCell: UITableViewCell {
    
    private lazy var titleView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceView: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackContentView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 12
        return view
    }()
    
    private lazy var stackTextView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var thumbnail: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResultSearchCell: UIConfigurations {
    
    func setupHierarchy() {
        stackTextView.addArrangedSubview(titleView)
        stackTextView.addArrangedSubview(priceView)
        stackContentView.addArrangedSubview(productImageView)
        stackContentView.addArrangedSubview(stackTextView)
        productImageView.addSubview(loadingIndicator)
        contentView.addSubview(stackContentView)
    }
    
    func setupConstraints() {
        setupProductImageView()
        setupTitleView()
        setupPriceView()
        setupStackTextView()
        setupStackContentView()
        setupLoadingIndicator()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor).isActive = true
                loadingIndicator.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor).isActive = true
    }
    
    private func setupProductImageView() {
        productImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupTitleView() {
        titleView.leadingAnchor.constraint(equalTo: stackTextView.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: stackTextView.trailingAnchor).isActive = true
    }
    
    private func setupPriceView() {
        priceView.leadingAnchor.constraint(equalTo: stackTextView.leadingAnchor).isActive = true
        priceView.trailingAnchor.constraint(equalTo: stackTextView.trailingAnchor).isActive = true
    }
    
    private func setupStackTextView() {
        stackTextView.bottomAnchor.constraint(equalTo: stackContentView.bottomAnchor, constant: -30).isActive = true
    }
    
    private func setupStackContentView() {
        stackContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stackContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        stackContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true
    }
}

extension ResultSearchCell {
    
    func configure(with produto: ResultSearchProduct) {
        titleView.text = produto.title
        priceView.text = "Price: \(produto.price)"
        thumbnail = produto.thumbnail
        productImageView.image = nil
        loadingIndicator.startAnimating()
        
        ImageLoader.shared.loadImage(from: produto.thumbnail) { [weak self] image, url in
            guard let self = self else { return }
            if self.thumbnail == url { 
                DispatchQueue.main.async {
                    self.productImageView.image = image
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
}
