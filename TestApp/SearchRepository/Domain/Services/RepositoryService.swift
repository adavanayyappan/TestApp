//
//  RepositoryService.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 15/12/23.
//

import Foundation
import Combine

protocol RepositoryService {
    func searchRepository(query: String, currentPage: Int) -> AnyPublisher<RepositoryList, Error>
}
