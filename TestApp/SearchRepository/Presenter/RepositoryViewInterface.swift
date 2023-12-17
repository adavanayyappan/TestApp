//
//  RepositoryViewInterface.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import Foundation

protocol RepositoryViewInterface: AnyObject {
    func presentRepositoryViewData(viewData: RepositoryList)
    func presentProgressStart()
    func presentProgressFinish()
    func presentErrorViewData(error: Error?)
}
