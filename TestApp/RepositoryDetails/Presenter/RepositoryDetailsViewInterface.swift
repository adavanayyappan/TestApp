//
//  RepositoryDetailsViewInterface.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import Foundation

protocol RepositoryDetailsViewInterface: AnyObject {
    func presentRepositoryViewData(repositoryData: Repository)
    func presentRepositoryContributorsViewData(contributorData: [RepositoryContributor])
    func presentProgressStart()
    func presentProgressFinish()
    func presentErrorViewData(error: Error?)
}
