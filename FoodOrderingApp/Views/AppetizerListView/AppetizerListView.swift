//
//  AppetizerListView.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct AppetizerListView: View {
    
    @EnvironmentObject private var order: Order
    @StateObject private var appetizerViewModel = AppetizerViewModel()
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack {
                NavigationView {
                    VStack {
                        TopHeaadingView()
                            .padding(.vertical, 15)
                        TopBannerView(frameWidth: (geometry.size.width - 70), frameHeight: 150)
                            .frame(width: 280, height: 130, alignment: .top)
                            .padding(.bottom, 30)
                        Text("Popular Now")
                            .font(.system(size: 22, weight: .bold, design: .default))
                            .frame(width: (geometry.size.width - 15), height: 30, alignment: .leading)
                            .padding(.leading, 30)
                        ScrollView {
                            LazyVGrid(columns: appetizerViewModel.getColumns(), alignment: .center, spacing: 33) {
                                ForEach(appetizerViewModel.appetizers, id: \.id) { appetizer in
                                    NavigationLink(destination: AppetizerDetail(viewModel: AppetizerDetailViewModel(order: order, appetizer: appetizer))) {
                                        AppetizerCell(appetizer: appetizer)
                                            .frame(width: (geometry.size.width / 2) - 30, height: 180, alignment: .center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 35)
                        }
                    }
                    .navigationBarHidden(true)
                }
                .onAppear { appetizerViewModel.getAppetizers() }
                
                if appetizerViewModel.isLoading { LoadingView() }
            }
        }
        .alert(item: $appetizerViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
    
}


struct AppetizerListView_Previews: PreviewProvider {
    
    static let order = Order()
    
    static var previews: some View {
        AppetizerListView().environmentObject(order)
    }
}

struct TopBannerView: View {
    
    var frameWidth: CGFloat = 280
    var frameHeight: CGFloat = 130
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: frameWidth, height: frameHeight)
                .foregroundColor(Color("appColor-1"))
                .cornerRadius(20)
            HStack {
                VStack(alignment: .leading) {
                    Text("The Fastest In")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(Color.black)
                    HStack {
                        Text("Delivery")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(Color.black)
                        Text("Food")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(Color.red)
                    }
                    Button {
                        print("Order Pressed")
                    } label: {
                        Text("Order Now")
                            .font(.system(size: 15, weight: .semibold))
                            .frame(width: 110, height: 35)
                            .background(Color("appColor2"))
                            .foregroundColor(.white)
                            .cornerRadius(17.5)
                    }
                }
                .padding(.leading, 20)
                Spacer()
                Image("rider")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: .center)
                    .padding(.trailing, 20)
            }
        }
    }
}

struct TopHeaadingView: View {
    var body: some View {
        HStack() {
            Button {
                print("Menu Pressed")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color("menuButtonColor"))
                        .cornerRadius(10)
                    Image("menu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                }
                .padding(.leading, 30)
            }
            Spacer()
            HStack {
                Image("location_pin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15, alignment: .center)
                Text("California, US")
                    .font(.system(size: 18, weight: .bold, design: .default))
            }
            Spacer()
            Button {
                print("Profile Pressed")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color("menuButtonColor"))
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                }
                .cornerRadius(10)
                .padding(.trailing, 30)
            }

        }
    }
}
