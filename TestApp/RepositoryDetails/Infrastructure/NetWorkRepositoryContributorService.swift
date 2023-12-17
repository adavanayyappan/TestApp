//
//  NetWorkRepositoryContributorService.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import Foundation
import Combine

struct NetWorkRepositoryContributorService: RepositoryContributorService {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getRepositoryContributor(owner: String, project: String) -> AnyPublisher<[RepositoryContributor], Error> {
        let endpoint = Endpoint.getRepositoryContributor(owner: owner, project: project)
        return networkService.get(type: [RepositoryContributor].self, url: endpoint.url, header: nil)
    }
}
