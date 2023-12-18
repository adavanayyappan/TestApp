//
//  RepositoryListTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
import XCTest
@testable import TestApp

class RepositoryListTests: XCTestCase {
    
    // MARK: - Decoding
    
    func testRepositoryJSONDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "repository_response", withExtension: "json") else {
            return XCTFail("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { return XCTFail("Data conversion failed.") }
        
        do {
            let response = try Mapper.decoder.decode(RepositoryList.self, from: data)
            XCTAssertEqual(response.totalCount, 1)
            XCTAssertEqual(response.items.count, 1)
            XCTAssertEqual(response.items[0].name, "swift")
            XCTAssertEqual(response.items[0].language, "C++")
            XCTAssertEqual(response.items[0].stargazersCount, 64743)
            XCTAssertNotNil(response.items[0].owner)
            XCTAssertEqual(response.items[0].owner?.login, "apple")
        } catch {
            XCTFail("JSON Decoding for class \(RepositoryList.self) failed.")
        }
    }
}
