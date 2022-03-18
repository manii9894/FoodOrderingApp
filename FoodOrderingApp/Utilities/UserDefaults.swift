//
//  UserDefaults.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 18/03/2022.
//

import Foundation

final class UserDefaultsHandler {
    
    static let shared = UserDefaultsHandler()
    let userDefaults = UserDefaults.standard
    
    private init() {}
    
    var userToken: String? {
        get {
            return userDefaults.value(forKey: Constants.Keys.userToken) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.Keys.userToken)
        }
    }
    
}
