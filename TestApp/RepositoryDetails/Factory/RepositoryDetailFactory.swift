//
//  RepositoryDetailFactory.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import Foundation
import UIKit

enum RepositoryDetailFactory {
    static func makeViewController(repository: Repository) -> UIViewController {
        let service: RepositoryContributorService = NetWorkRepositoryContributorService()
        let presenter: RepositoryDetailsViewPresenter = RepositoryDetailsViewPresenter(service: service, repository: repository)
        let view = RepositoryDetailViewController(presenter: presenter)
        presenter.attach(view: view)
        return view
    }
}
