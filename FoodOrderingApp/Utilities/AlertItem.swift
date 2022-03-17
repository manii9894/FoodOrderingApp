//
//  AlertItem.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    
    //MARK: - Network Errors
    static let invalidURL           = AlertItem(title: Text("Server Error"),
                                            message: Text("There is an error trying to reach the server. If this persists, please contact support."),
                                            dismissButton: .default(Text("Ok")))
    
    static let itemAdded            = AlertItem(title: Text("Success"),
                                            message: Text("Item successfully added to cart"),
                                            dismissButton: .default(Text("Ok")))
    
    static let itemAlreadyExists    = AlertItem(title: Text("Error"),
                                            message: Text("Item already exists in cart"),
                                            dismissButton: .default(Text("Ok")))
    
    static func getAlertItem(title: String, message: String) -> AlertItem {
        
        return AlertItem(title: Text(title),
                         message: Text(message),
                         dismissButton: .default(Text("Ok")))
        
    }
    
    
}


