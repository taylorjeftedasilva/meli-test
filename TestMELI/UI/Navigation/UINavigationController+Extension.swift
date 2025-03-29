//
//  UINavigationController+Extension.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 27/03/25.
//

import UIKit

extension CoordinatorViewController {
    
    func setupNavigationControllerColor(color: TestMELIColors.Colors = .amarelo) {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = TestMELIColors().getColor(color)
        appearance.shadowColor = .clear
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        let backButtonImage = UIImage(systemName: "arrow.left")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))

        let backButton = UIButton(type: .system)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


