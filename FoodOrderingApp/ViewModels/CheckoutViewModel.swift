//
//  CheckoutViewModel.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

final class CheckoutViewModel: ObservableObject {
    
    var order: Order
    let paymentMethods = ["Cash", "Credit/Debit card", "Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
    @Published var paymentType = 0
    @Published var addDiscountVoucher = false
    @Published var voucher = ""
    @Published var tip = 0
    @Published var showPaymentAlert = false
    
    init(order: Order) {
        self.order = order
    }
    
    func getTotalPrice() -> Double {
        let tipAmount = (Double(tipAmounts[tip]) / 100) * Double(order.total)
        return Double(order.total) + tipAmount
    }
    
}
