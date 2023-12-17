//
//  RepositoryFactory.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import UIKit

enum RepositoryFactory {
    static func makeViewController() -> UIViewController {
        let service: RepositoryService = NetworkRepositoryService()
        let presenter: RepositoryViewPresenter = RepositoryViewPresenter(service: service)
        let view = SearchViewController(presenter: presenter)
        let coordinator = RepositoryCoordinator(viewController: view)
        presenter.attach(view: view)
        presenter.coordinator = coordinator
        let navigationController = UINavigationController()
        navigationController.viewControllers = [view]
        return navigationController
    }
    
    private func navigationBarConfiguration (_ controller: UINavigationController) {
        let navBarAppearance = UINavigationBarAppearance()
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        controller.navigationBar.tintColor = .black
        navBarAppearance.backgroundColor = .white
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = .none
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
}
