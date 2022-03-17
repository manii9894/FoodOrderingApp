//
//  Order.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

class Order: ObservableObject {
    
    @Published var items = [Appetizer]()

    var total: Int {
        if items.count > 0 {
            return Int(items.reduce(0) { $0 + $1.price })
        } else {
            return 0
        }
    }

    func add(item: Appetizer) {
        items.append(item)
    }

    func remove(item: Appetizer) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
}
