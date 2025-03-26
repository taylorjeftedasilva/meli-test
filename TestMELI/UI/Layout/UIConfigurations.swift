//
//  UIConfigurations.swift
//  MarketplaceDelivery
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation


protocol UIConfigurations {
    func setup() -> Void
    func setupHierarchy() -> Void
    func setupConstraints() -> Void
    func setupConfigurations() -> Void
}

extension UIConfigurations {
    func setup() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }
    
    func setupConfigurations() {
        // Not implemented
    }
}
