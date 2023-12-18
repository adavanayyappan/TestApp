//
//  NetworkError.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 15/12/23.
//

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case dataLoadingError
    case jsonDecodingError
    
    var errorDescription: String{
        switch self {
        case .invalidRequest: return "Invalid request"
        case .invalidResponse: return "Invalid reponse"
        case .dataLoadingError: return "Data loading failed"
        case .jsonDecodingError: return "JSON decoding failed"
        }
    }
}
