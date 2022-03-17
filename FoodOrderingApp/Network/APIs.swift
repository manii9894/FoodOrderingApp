//
//  APIs.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

fileprivate let baseURL = "https://seanallen-course-backend.herokuapp.com/"

enum Endpoint: String {
    
    case appetizers = "swiftui-fundamentals/appetizers"
    
    var urlString: String {
        get {
            return baseURL + self.rawValue
        }
    }
    
}

enum APIMethod: String {
    case GET
    case POST
}
