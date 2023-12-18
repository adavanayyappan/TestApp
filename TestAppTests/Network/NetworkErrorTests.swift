//
//  NetworkErrorTests.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp
import XCTest

class NetworkErrorTests: XCTestCase {
    
    func testInvalidRequestError() {
        let error : NetworkError = .invalidRequest
        XCTAssertEqual(error.errorDescription, "Invalid request")
    }
    
    func testInvalidResponseError() {
        let error : NetworkError = .invalidResponse
        XCTAssertEqual(error.errorDescription, "Invalid reponse")
    }
    
    func testDataLoadingError() {
        let error : NetworkError = .dataLoadingError
        XCTAssertEqual(error.errorDescription, "Data loading failed")
    }
    
    func testJsonDecodingErrorError() {
        let error : NetworkError = .jsonDecodingError
        XCTAssertEqual(error.errorDescription, "JSON decoding failed")
    }
}
