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
    func showResultSearch(search: String) -> Void
    func showError(_ error: APIError, retryAgain: (() -> Void)?) -> Void
}

final class ListProductCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = ListProductViewModel()
        let listProductsController = ListProductController(coordinator: self,
                                                           nibName: nil,
                                                           bundle: nil,
                                                           viewModel: viewModel)
        listProductsController.delegate = self
        configuration.navigationController?.isNavigationBarHidden = true
        configuration.navigationController?.pushViewController(listProductsController, animated: true)
    }
}

extension ListProductCoordinator: ListProductCoordinatorProtocol {
    
    func showError(_ error: APIError, retryAgain: (() -> Void)?) {
        let errorCoordinator = ErrorCoordinator(with: configuration)
        errorCoordinator.errorType = error
        errorCoordinator.closeAction = popController
        errorCoordinator.tryAgainAction = retryAgain
        errorCoordinator.start()
    }
    
    func showDetail(_ id: Int) {
        let detail = DetailProductCoordinator(with: configuration, parentCoordinator: self)
        detail.productID = id
        detail.start()
    }
    
    func showResultSearch(search: String) {
        let detail = ResultSearchCoordinator(with: configuration, parentCoordinator: self)
        detail.search = search
        detail.start()
    }
    
    private func popController() {
        configuration.navigationController?.popViewController(animated: true)
    }
}
