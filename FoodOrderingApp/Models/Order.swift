//
//  Order.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

class Order: ObservableObject {
    
    @Published var items = [AppetizerVM]()

    var total: Int {
        if items.count > 0 {
            return Int(items.reduce(0) { $0 + $1.getPrice })
        } else {
            return 0
        }
    }

    func add(item: AppetizerVM) {
        items.append(item)
    }

    func remove(item: AppetizerVM) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
}
