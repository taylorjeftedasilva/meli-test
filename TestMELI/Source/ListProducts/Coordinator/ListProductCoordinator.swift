//
//  ListProductCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

class ListProductCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = ListProductViewModel()
        let listProductsController = ListProductController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        configuration.navigationController?.pushViewController(listProductsController, animated: true)
    }
}
