//
//  RepositoryViewModel.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import Foundation
import Combine

class RepositoryViewPresenter {
    private weak var view: RepositoryViewInterface?
    private let service: RepositoryService
    var coordinator: RepositoryCoordinating?
    private var cancellables = Set<AnyCancellable>()
    
    init(service: RepositoryService) {
        self.service = service
    }
    
    func attach(view: RepositoryViewInterface) {
        self.view = view
    }
}

extension RepositoryViewPresenter: RepositoryViewHandler {
    func selectRepository(_ repository: Repository) {
        coordinator?.showRepositoryDetails(repository: repository)
    }
    
    func searchRepository(query: String, currentPage: Int) {
        view?.presentProgressStart()
        service.searchRepository(query: query, currentPage: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.view?.presentProgressFinish()
                    self?.view?.presentErrorViewData(error: error)
                case .finished: break
                }
            } receiveValue: { [weak self] repo in
                self?.view?.presentProgressFinish()
                self?.view?.presentRepositoryViewData(viewData: repo)
                print("Result count = \(repo.items.count)")
            }
            .store(in: &cancellables)
    }
}
