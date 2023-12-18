//
//  MockRepositoryService.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
import Combine
@testable import TestApp

class MockRepositoryService: RepositoryService {
    
    var wasSearchRepoCalled = false
    
    var fileName: String = "repository_response"
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func searchRepository(query: String, currentPage: Int) -> AnyPublisher<TestApp.RepositoryList, Error> {
        wasSearchRepoCalled = true
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: fileName, withExtension: "json") else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            return Fail(error: NetworkError.dataLoadingError).eraseToAnyPublisher() }
        
        return Just(data)
            .decode(type: RepositoryList.self, decoder: decoder)
            .mapError {_ in NetworkError.jsonDecodingError}
            .eraseToAnyPublisher()
    }
}
