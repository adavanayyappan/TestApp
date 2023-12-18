//
//  RepositoryFactoryTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp
import XCTest

class RepositoryFactoryTests: XCTestCase {
    
    func testViewCreation() {
        let viewController = RepositoryFactory.makeViewController()
        XCTAssertTrue(viewController.isKind(of: UINavigationController.self))
    }
}

