//
//  RepositoryDetailsViewHandler.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import Foundation

protocol RepositoryDetailsViewHandler {
    func getRepositoryContributor(completionHandler: @escaping ()->Void)
}
