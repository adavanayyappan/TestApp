//
//  RepositoryDetailsViewPresenterTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp
import XCTest

class RepositoryDetailsViewPresenterTests: XCTestCase {
    
    var sut: RepositoryDetailsViewPresenter!
    var view: MockRepositoryDetailsViewInterface!
    var service: MockRepositoryContributorService!
    
    override func setUp() {
        super.setUp()
        self.view = MockRepositoryDetailsViewInterface()
    }
    
    func testRepoContributorSuccess() {
        service = MockRepositoryContributorService(fileName: "repository_contributor_response")
        let repo = Repository(name: "Adavan", fullName: "Adavan", language: "Swift", createdAt: nil, stargazersCount: nil, owner: nil)
        
        sut = RepositoryDetailsViewPresenter(service: service, repository: repo)
        sut.attach(view: view)
        
        let exp = expectation(description: "Loading Repo Details")
        sut.getRepositoryContributor {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(view.wasProgressStartCalled, true)
        XCTAssertEqual(view.waspresentRepositoryViewDataCalled, true)
        XCTAssertEqual(view.waspresentContributorsViewDataCalled, true)
        XCTAssertEqual(view.wasProgressEndCalled, true)
    }
    
    func testRepoContributorFailure() {
        service = MockRepositoryContributorService(fileName: "repository_contributor_fail")
        let repo = Repository(name: "Adavan", fullName: "Adavan", language: "Swift", createdAt: nil, stargazersCount: nil, owner: nil)
        
        sut = RepositoryDetailsViewPresenter(service: service, repository: repo)
        sut.attach(view: view)
        
        let exp = expectation(description: "Loading Repo Details")
        sut.getRepositoryContributor {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(view.wasProgressStartCalled, true)
        XCTAssertEqual(view.waspresentErrorViewDataCalled, true)
        XCTAssertEqual(view.wasProgressEndCalled, true)
    }
}
