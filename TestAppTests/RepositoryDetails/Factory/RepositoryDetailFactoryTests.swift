//
//  RepositoryDetailFactoryTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp
import XCTest

class RepositoryDetailFactoryTests: XCTestCase {
    
    func testViewCreation() {
        let repo = Repository(name: "Adavan", fullName: "Adavan", language: "Swift", createdAt: nil, stargazersCount: nil, owner: nil)
        let viewController = RepositoryDetailFactory.makeViewController(repository: repo)
        XCTAssertTrue(viewController.isKind(of: RepositoryDetailViewController.self))
    }
}
