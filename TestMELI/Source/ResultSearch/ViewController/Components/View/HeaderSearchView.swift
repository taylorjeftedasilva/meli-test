//
//  HeaderSearchView.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

import UIKit

class HeaderSearchView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(searchQuery: String, hasResults: Bool) {
        super.init(frame: .zero)
        setupView()
        configure(with: searchQuery, hasResults: hasResults)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = TestMELIColors().getColor(.amarelo)
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with searchQuery: String, hasResults: Bool) {
        let boldText = hasResults ? "Resultados para: " : "Não foram encontrados resultados para "
        let normalText = "\"\(searchQuery)\""
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .medium),
            .foregroundColor: UIColor.white
        ]
        
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        attributedString.append(NSAttributedString(string: normalText, attributes: normalAttributes))
        
        titleLabel.attributedText = attributedString
    }
}
