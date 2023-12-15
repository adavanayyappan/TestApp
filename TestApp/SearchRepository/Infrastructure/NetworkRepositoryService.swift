//
//  NetworkRepositoryService.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import Foundation
import Combine

struct NetworkRepositoryService: RepositoryService {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func searchRepository(query: String) -> AnyPublisher<RepositoryList, Error> {
        let endpoint = Endpoint.searchRepository(query: query)
        return networkService
            .get(type: RepositoryList.self, url: endpoint.url, header: nil)
    }

}
