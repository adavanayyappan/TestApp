//
//  RepositoryContributorService.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import Foundation
import Combine

protocol RepositoryContributorService {
    func getRepositoryContributor(owner: String, project: String) -> AnyPublisher<[RepositoryContributor], Error>
}
