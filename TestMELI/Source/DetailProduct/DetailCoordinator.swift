//
//  DetailCoordinator.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

class DetailCoordinator: BaseCoordinator {
    
    var productID: String? = nil
    
    override func start() {
        let viewModel = DetailViewModel()
        let detailController = DetailViewController(coordinator: self,
                                                      nibName: nil,
                                                      bundle: nil,
                                                      viewModel: viewModel)
        configuration.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
