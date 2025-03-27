//
//  ListProductCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 25/03/25.
//

import Foundation
import UIKit

protocol ListProductCoordinatorProtocol: AnyObject {
    func showDetail(_ id: Int) -> Void
}

class ListProductCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = ListProductViewModel()
        let listProductsController = ListProductController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        listProductsController.delegate = self
        configuration.navigationController?.pushViewController(listProductsController, animated: true)
    }
}

extension ListProductCoordinator: ListProductCoordinatorProtocol {
    func showDetail(_ id: Int) {
        let detail = DetailCoordinator(with: configuration, parentCoordinator: self)
        detail.start()
    }
}
