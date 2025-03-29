//
//  ResultSearchCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 28/03/25.
//

import Foundation
import UIKit

protocol ResultSearchCoordinatorProtocol: AnyObject {
    func showDetail(_ id: Int) -> Void
    func showError(_ error: APIError) -> Void
}

class ResultSearchCoordinator: BaseCoordinator {
    
    var search: String? = nil
    
    override func start() {
        guard let search = search else { return }
        let viewModel = ResultSearchViewModel(search: search)
        let resultSearchController = ResultSearchController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        resultSearchController.delegate = self
        configuration.navigationController?.pushViewController(resultSearchController, animated: true)
    }
}

extension ResultSearchCoordinator: ResultSearchCoordinatorProtocol {
    
    func showError(_ error: APIError) {
        let errorCoordinator = ErrorCoordinator(with: configuration)
        errorCoordinator.errorType = error
        errorCoordinator.start()
    }
    
    func showDetail(_ id: Int) {
        let detail = DetailProductCoordinator(with: configuration, parentCoordinator: self)
        detail.productID = id
        detail.start()
    }
}
