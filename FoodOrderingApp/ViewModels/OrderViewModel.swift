//
//  OrderViewModel.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import UIKit
import SwiftUI

final class OrderViewModel: ObservableObject {
    
    var order: Order
    @Published var isCartEmpty = true
    
    init(order: Order) {
        self.order = order
        checkCartForItems()
    }
    
    func deleteItemFromOrder(index: IndexSet) {
        order.items.remove(atOffsets: index)
        checkCartForItems()
    }
    
    func checkCartForItems() {
        isCartEmpty = order.items.count == 0 ? true : false
    }
    
}
