//
//  CheckoutView.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct CheckoutView: View {
    
    @StateObject var viewModel: CheckoutViewModel
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $viewModel.paymentType) {
                    ForEach(0..<viewModel.paymentMethods.count) {
                        Text(viewModel.paymentMethods[$0])
                    }
                }
                Toggle(isOn: $viewModel.addDiscountVoucher.animation()) {
                    Text("Add discount voucher")
                }
                if viewModel.addDiscountVoucher {
                    TextField("Enter voucher code", text: $viewModel.voucher)
                }
            }
            Section(header: Text("Add a Tip?")) {
                Picker("Percentage", selection: $viewModel.tip) {
                    ForEach(0..<viewModel.tipAmounts.count) {
                        Text("\(viewModel.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header:
                        Text("TOTAL: $\(viewModel.getTotalPrice(), specifier: "%.2f")").font(.title)
            ) {
                Button("Confirm order") {
                    viewModel.showPaymentAlert = true
                }
            }
        }.navigationBarTitle(Text("Payment"), displayMode: .inline)
            .alert(isPresented: $viewModel.showPaymentAlert) {
                Alert(title: Text("Order confirmed"), message: Text("Your total was  $\(viewModel.getTotalPrice(), specifier: "%.2f")"), dismissButton: .default(Text("Ok")))
            }
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    
    static let order = Order()
    static var previews: some View {
        CheckoutView(viewModel: CheckoutViewModel(order: order)).environmentObject(order)
    }
    
}
