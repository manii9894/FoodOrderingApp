//
//  Erros.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
    case generic
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .generic:
            return NSLocalizedString("Something went wrong", comment: "Something went wrong")
        }
    }
}
