//
//  MockRepositoryViewInterface.swift
//  TestAppTests
//
//  Created by Adavan Ayyappan on 18/12/23.
//

import Foundation
@testable import TestApp

class MockRepositoryViewInterface: RepositoryViewInterface {
    
    var waspresentRepositoryViewDataCalled = false
    var wasProgressStartCalled = false
    var wasProgressEndCalled = false
    var waspresentErrorViewDataCalled = false
    
    var viewData: TestApp.RepositoryList?
    var error: Error?
    
    func presentRepositoryViewData(viewData: TestApp.RepositoryList) {
        waspresentRepositoryViewDataCalled = true
        self.viewData = viewData
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
