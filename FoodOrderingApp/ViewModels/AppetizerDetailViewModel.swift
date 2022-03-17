//
//  AppetizerDetailViewModel.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import UIKit
import SwiftUI

final class AppetizerDetailViewModel: ObservableObject {
    
    var order: Order
    @Published var alertItem: AlertItem?
    var appetizer: Appetizer
    
    init(order: Order, appetizer: Appetizer) {
        self.order = order
        self.appetizer = appetizer
    }
    
    func addItemToCart() {
        
        if !order.items.contains(appetizer) {
            order.add(item: appetizer)
            alertItem = AlertContext.itemAdded
        } else {
            alertItem = AlertContext.itemAlreadyExists
        }
        
    }
    
}
