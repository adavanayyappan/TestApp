//
//  EndPoint.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path =  path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension Endpoint {
    static func searchRepository(query: String, currentPage: Int) -> Self {
        return Endpoint(path: "/search/repositories",
                        queryItems: [
                            URLQueryItem(name: "q",
                                         value: "\(query)"),
                            URLQueryItem(name: "page", value: "\(currentPage)")
                        ]
        )
    }
    
    static func getRepositoryContributor(owner: String, project: String) -> Self {
        return Endpoint(path: "/repos/\(owner)/\(project)/contributors",
                        queryItems: [
                            URLQueryItem(name: "anon",
                                         value: "\(1)"),
                            URLQueryItem(name: "per_page", value: "\(3)")
                        ]
        )
    }
}
