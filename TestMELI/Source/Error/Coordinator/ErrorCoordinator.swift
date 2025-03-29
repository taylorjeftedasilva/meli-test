//
//  ErrorCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 29/03/25.
//

protocol ErrorCoordinatorProtocol: AnyObject {
    func tryAgain(completion: @escaping () -> Void) -> Void
    func close() -> Void
}

extension ErrorCoordinatorProtocol {
    
    /// Description
    /// This method only implemented when there is a previous Controller, then is possible return to loaded view.
    /// Default implementation is an empty called
    func close() {
        // non-mandatory method
    }
}

class ErrorCoordinator: BaseCoordinator {
    
    weak var delegate: ErrorCoordinatorProtocol? = nil
    var errorType: APIError? = nil
    
    override func start() {
        guard let errorType = errorType else {
            return
        }
        let viewModel = ErrorViewModel()
        viewModel.errorType = errorType
        let errorViewController = ErrorViewController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        errorViewController.modalPresentationStyle = .fullScreen
        configuration.navigationController?.present(errorViewController, animated: true)
    }
}

extension ErrorCoordinator {
    
    func tryAgain() {
        delegate?.tryAgain { [weak self] in
            self?.start()
        }
    }
    
    func close() {
        delegate?.close()
        self.configuration.navigationController?.dismiss(animated: true)
    }
}
