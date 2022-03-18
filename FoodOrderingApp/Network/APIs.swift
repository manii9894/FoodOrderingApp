//
//  APIs.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

enum ServerEnvironment: String {
    
    case staging = "https://seanallen-course-backend.herokuapp.com/"
    case production = ""
    
    static var baseUrl: String {
        #if DEBUG
        ServerEnvironment.staging.rawValue
        #else
        ServerEnvironment.production.rawValue
        #endif
    }
    
}

enum Endpoint: String {
    
    case appetizers = "swiftui-fundamentals/appetizers"
    
    var urlString: String {
        get {
            return ServerEnvironment.baseUrl + self.rawValue
        }
    }
    
}

enum APIMethod: String {
    case GET
    case POST
}
