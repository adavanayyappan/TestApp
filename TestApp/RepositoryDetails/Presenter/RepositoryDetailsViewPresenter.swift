//
//  RepositoryDetailsViewPresenter.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import Foundation
import Combine

class RepositoryDetailsViewPresenter {
    private weak var view: RepositoryDetailsViewInterface?
    private let service: RepositoryContributorService
    private let repository: Repository
    private var cancellables = Set<AnyCancellable>()
    
    init(service: RepositoryContributorService,
         repository: Repository) {
        self.service = service
        self.repository = repository
    }
    
    func attach(view: RepositoryDetailsViewInterface) {
        self.view = view
    }
}

extension RepositoryDetailsViewPresenter: RepositoryDetailsViewHandler {
    func getRepositoryContributor(completionHandler: @escaping ()->Void) {
        view?.presentRepositoryViewData(repositoryData: repository)
        view?.presentProgressStart()
        let owner = repository.owner?.login ?? ""
        let project = repository.name ?? ""
        service.getRepositoryContributor(owner: owner, project: project)
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
            } receiveValue: { [weak self] contributorsList in
                self?.view?.presentProgressFinish()
                self?.view?.presentRepositoryContributorsViewData(contributorData: contributorsList)
                print("Result count = \(contributorsList.count)")
                completionHandler()
            }
            .store(in: &cancellables)
    }
}
