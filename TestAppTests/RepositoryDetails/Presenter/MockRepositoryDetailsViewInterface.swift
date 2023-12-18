//
//  MockRepositoryDetailsViewInterface.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp

class MockRepositoryDetailsViewInterface: RepositoryDetailsViewInterface {
    
    var waspresentRepositoryViewDataCalled = false
    var waspresentContributorsViewDataCalled = false
    var wasProgressStartCalled = false
    var wasProgressEndCalled = false
    var waspresentErrorViewDataCalled = false
    
    var repositoryData: TestApp.Repository?
    var contributorData: [RepositoryContributor]?
    var error: Error?
    
    func presentRepositoryViewData(repositoryData: Repository) {
        waspresentRepositoryViewDataCalled = true
        self.repositoryData = repositoryData
    }
    
    func presentRepositoryContributorsViewData(contributorData: [RepositoryContributor]) {
        waspresentContributorsViewDataCalled = true
        self.contributorData = contributorData
    }
    
    func presentProgressStart() {
        wasProgressStartCalled = true
    }
    
    func presentProgressFinish() {
        wasProgressEndCalled = true
    }
    
    func presentErrorViewData(error: Error?) {
        waspresentErrorViewDataCalled = true
        self.error = error
    }
}
