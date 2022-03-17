//
//  MainView.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var order: Order
    @State private var currentIndex = 0
    private let tabImages = ["menucard", "cart.fill"]
    
    var body: some View {
        VStack {
            ZStack {
                switch currentIndex {
                case 0:
                    AppetizerListView()
                case 1:
                    OrderView(viewModel: OrderViewModel(order: order))
                default:
                    Text("None")
                }
            }
            Divider()
                .padding(.bottom, 10)
            HStack {
                ForEach(0..<tabImages.count) { num in
                    Spacer()
                    Button {
                        currentIndex = num
                    } label: {
                        TabItem(color: currentIndex == num ? Color.red : Color.gray, image: tabImages[num])
                    }
                    Spacer()
                }
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static let order = Order()
    static var previews: some View {
        MainView().environmentObject(order)
    }
}

struct TabItem: View {
    
    var color: Color
    var image: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(color)
            if color == .red {
                Circle()
                    .frame(width: 7, height: 7, alignment: .bottom)
                    .foregroundColor(color)
            } else {
                Circle()
                    .frame(width: 7, height: 7, alignment: .bottom)
                    .foregroundColor(.white)
                    .hidden()
            }
        }
    }
    
}
