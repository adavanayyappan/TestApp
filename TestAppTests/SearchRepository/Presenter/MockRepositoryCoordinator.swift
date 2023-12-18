//
//  MockRepositoryCoordinator.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp

class MockRepositoryCoordinator: RepositoryCoordinating {
    var didRepoDetailCalled = false
    
    func showRepositoryDetails(repository: TestApp.Repository) {
        self.didRepoDetailCalled = true
    }
}
