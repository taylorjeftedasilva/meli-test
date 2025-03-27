//
//  DetailProductCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

class DetailProductCoordinator: BaseCoordinator {
    
    var productID: Int? = nil
    
    override func start() {
        guard let productID = productID else { return }
        let viewModel = DetailProductViewModel(id: productID)
        let detailController = DetailProductViewController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        configuration.navigationController?.isNavigationBarHidden = false
        configuration.navigationController?.setupNavigationControllerColor()
        configuration.navigationController?.pushViewController(detailController, animated: true)
    }
}
