//
//  RepositoryViewPresenterTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp
import XCTest

class RepositoryViewPresenterTests: XCTestCase {
    
    var sut: RepositoryViewPresenter!
    var view: MockRepositoryViewInterface!
    var service: MockRepositoryService!
    var coordinator: MockRepositoryCoordinator!
    
    
    override func setUp() {
        super.setUp()
        
        self.view = MockRepositoryViewInterface()
        self.coordinator = MockRepositoryCoordinator()
        
    }
    
    func testSearchRepositorySuccess() {
        service = MockRepositoryService(fileName: "repository_response")
        
        sut = RepositoryViewPresenter(service: service)
        sut.attach(view: view)
        sut.coordinator = coordinator
        let exp = expectation(description: "Loading Repo")
        sut.searchRepository(query: "Swift", currentPage: 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(view.wasProgressStartCalled, true)
        XCTAssertEqual(view.waspresentRepositoryViewDataCalled, true)
        XCTAssertEqual(view.wasProgressEndCalled, true)
    }
    
    func testSearchRepositoryFailure() {
        service = MockRepositoryService(fileName: "repository_fail")
        
        sut = RepositoryViewPresenter(service: service)
        sut.attach(view: view)
        sut.coordinator = coordinator
        let exp = expectation(description: "Loading Repo")
        sut.searchRepository(query: "Swift", currentPage: 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(view.wasProgressStartCalled, true)
        XCTAssertEqual(view.waspresentErrorViewDataCalled, true)
        XCTAssertEqual(view.wasProgressEndCalled, true)
    }
    
    func testSelectRepository() {
        service = MockRepositoryService(fileName: "repository_response")
        
        sut = RepositoryViewPresenter(service: service)
        sut.attach(view: view)
        sut.coordinator = coordinator
        
        sut.selectRepository(Repository(name: "Adavan", fullName: "Adavan", language: "Swift", createdAt: nil, stargazersCount: nil, owner: nil))
        
        XCTAssertEqual(coordinator.didRepoDetailCalled, true)
    }
    
}
