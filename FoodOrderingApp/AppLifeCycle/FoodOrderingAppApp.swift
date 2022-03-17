//
//  FoodOrderingAppApp.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

@main
struct FoodOrderingAppApp: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen().environmentObject(order)
        }
    }
    
}
