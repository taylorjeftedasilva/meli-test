//
//  DetailProductCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

protocol DetailProductCoordinatorProtocol: AnyObject {
    func showError(_ error: APIError, retryAgain: (() -> Void)?) -> Void
}

final class DetailProductCoordinator: BaseCoordinator {
    
    var productID: Int? = nil
    
    override func start() {
        guard let productID = productID else { return }
        let viewModel = DetailProductViewModel(id: productID)
        let detailController = DetailProductViewController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        detailController.delegate = self
        configuration.navigationController?.pushViewController(detailController, animated: true)
    }
}

extension DetailProductCoordinator: DetailProductCoordinatorProtocol {
    
    func showError(_ error: APIError, retryAgain: (() -> Void)?) {
        let errorCoordinator = ErrorCoordinator(with: configuration)
        errorCoordinator.errorType = error
        errorCoordinator.closeAction = popController
        errorCoordinator.tryAgainAction = retryAgain
        errorCoordinator.start()
    }
    
    private func popController() {
        configuration.navigationController?.popViewController(animated: true)
    }
}
