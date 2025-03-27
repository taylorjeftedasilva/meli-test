//
//  DetailViewController.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 26/03/25.
//

import Foundation

class DetailViewController: CoordinatorViewController {
    
    private let viewModel: DetailViewModel
    
    init(coordinator: CoordinatorProtocol, nibName: String? = nil, bundle: Bundle? = nil, viewModel: DetailViewModel) {
        self.viewModel  = viewModel
        super.init(coordinator: coordinator, nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green
    }
}
