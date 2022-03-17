//
//  NSMutableData+Extension.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

extension NSMutableData {
    
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
}
