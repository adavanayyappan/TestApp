//
//  RepositoryContributorTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
import XCTest
@testable import TestApp

class RepositoryContributorTests: XCTestCase {
    
    // MARK: - Decoding
    
    func testRepositoryContributorJSONDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "repository_contributor_response", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }
        
        do {
            let response = try Mapper.decoder.decode([RepositoryContributor].self, from: data)
            XCTAssertEqual(response.count, 3)
            XCTAssertEqual(response[0].login, "swift-ci")
            XCTAssertEqual(response[0].id, 15467072)
            
            XCTAssertEqual(response[1].login, "DougGregor")
            XCTAssertEqual(response[1].id, 989428)
            
            XCTAssertEqual(response[2].login, "slavapestov")
            XCTAssertEqual(response[2].id, 66486)
            
        } catch {
            XCTFail("JSON Decoding for class \(RepositoryList.self) failed.")
        }
    }
}
