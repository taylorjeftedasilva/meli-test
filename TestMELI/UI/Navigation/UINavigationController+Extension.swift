//
//  UINavigationController+Extension.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 27/03/25.
//

import UIKit

extension UINavigationController {
    
    func setupNavigationControllerColor(color: TestMELIColors.Colors = .amarelo) {
        self.navigationBar.isTranslucent = false
        let backButtonImage = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        self.navigationBar.tintColor = .white
    }
}
