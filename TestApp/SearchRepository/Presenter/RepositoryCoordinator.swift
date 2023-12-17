//
//  RepositoryCoordinator.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import UIKit

struct RepositoryCoordinator: RepositoryCoordinating {
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showRepositoryDetails(repository: Repository) {
        let detailsVc = RepositoryDetailFactory.makeViewController(repository: repository)
        viewController.navigationController?.pushViewController(detailsVc, animated: true)
    }
}
