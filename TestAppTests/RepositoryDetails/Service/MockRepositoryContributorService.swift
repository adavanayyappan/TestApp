//
//  RepositoryContributorServiceTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
import Combine
@testable import TestApp

class MockRepositoryContributorService: RepositoryContributorService {
    
    var wasRepoDetailsCalled = false
    
    var fileName: String = "repository_contributor_response"
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func getRepositoryContributor(owner: String, project: String) -> AnyPublisher<[RepositoryContributor], Error> {
        wasRepoDetailsCalled = true
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: fileName, withExtension: "json") else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            return Fail(error: NetworkError.dataLoadingError).eraseToAnyPublisher() }
        
        return Just(data)
            .decode(type: [RepositoryContributor].self, decoder: decoder)
            .mapError {_ in NetworkError.jsonDecodingError}
            .eraseToAnyPublisher()
    }
    
}
