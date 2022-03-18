//
//  HttpHeader.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 18/03/2022.
//

import Foundation

struct Header {
    
    var value: String
    var field: String
    
}

enum HttpHeader: String {
    
    case authorization
    case none
    
    func getHeader() -> Header? {
        
        switch self {
        case .authorization:
            if let token = UserDefaultsHandler.shared.userToken {
                return Header(value: "Bearer \(token)", field: "Authorization")
            }
            return nil
        case .none:
            return nil
        }
        
    }
    
}
