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
    /// Select Repository router method
    /// - Parameter repository: selected repository
    func selectRepository(_ repository: Repository) {
        coordinator?.showRepositoryDetails(repository: repository)
    }
    
    ///  Search Repository API Method
    /// - Parameters:
    ///   - query: search query
    ///   - currentPage:  page index position
    ///   - completionHandler:  completion block
    func searchRepository(query: String, currentPage: Int, completionHandler : @escaping ()->Void) {
        view?.presentProgressStart()
        service.searchRepository(query: query, currentPage: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.view?.presentProgressFinish()
                    self?.view?.presentErrorViewData(error: error)
                    completionHandler()
                case .finished: break
                }
            } receiveValue: { [weak self] repo in
                self?.view?.presentProgressFinish()
                self?.view?.presentRepositoryViewData(viewData: repo)
                print("Result count = \(repo.items.count)")
                completionHandler()
            }
            .store(in: &cancellables)
    }
}
