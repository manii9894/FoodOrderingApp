//
//  OrderView.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel: OrderViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isCartEmpty {
                    Section {
                        Text("Your Cart is empty!")
                            .foregroundColor(.red)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                Section {
                    ForEach(viewModel.order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.getPriceString())")
                        }
                    }.onDelete(perform: { indexSet in
                        viewModel.deleteItemFromOrder(index: indexSet)
                    })
                }
                if !viewModel.isCartEmpty {
                    Section {
                        NavigationLink(destination: CheckoutView(viewModel: CheckoutViewModel(order: viewModel.order))) {
                            Text("Place Order")
                        }
                    }
                }
            }
            .navigationBarTitle("Cart", displayMode: .inline).listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton().disabled(viewModel.isCartEmpty))
        }
        .onAppear {
            viewModel.checkCartForItems()
        }
    }
    
}

struct OrderView_Previews: PreviewProvider {
    
    static let order = Order()
    static var previews: some View {
        OrderView(viewModel: OrderViewModel(order: order)).environmentObject(order)
    }
}
