//
//  AppetizerDetail.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct AppetizerDetail: View {
    
    @StateObject var viewModel: AppetizerDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack : some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color.white)
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .cornerRadius(10)
        }
    }
    
    var btnMenu: some View {
        Button {
            print("Profile Pressed")
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                Image("dots")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
            }
            .cornerRadius(10)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("bg_doodle")
                    .resizable()
                    .edgesIgnoringSafeArea(.vertical)
                    .opacity(0.25)
                VStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(50, corners: [.topLeft, .topRight])
                            .foregroundColor(Color.white)
                        VStack {
                            Spacer()
                            Image("burger")
                                .resizable()
                                .frame(maxWidth: 200, alignment: .center)
                                .aspectRatio(1, contentMode: .fit)
                            ItemCountView()
                            HStack(alignment: .top) {
                                Text(viewModel.appetizer.name)
                                    .font(.system(size: 30, weight: .bold, design: .default))
                                    .foregroundColor(Color(.label))
                                    .lineLimit(nil)
                                Spacer()
                                Text("$\(viewModel.appetizer.getPriceString())")
                                    .font(.system(size: 28, weight: .semibold, design: .default))
                                    .foregroundColor(Color(.label))
                            }
                            HStack {
                                ItemDetailView(imageName: "star", textString: "4.8")
                                Spacer()
                                ItemDetailView(imageName: "fire", textString: "\(viewModel.appetizer.calories) kcal")
                                Spacer()
                                ItemDetailView(imageName: "clock", textString: "5-10 Min")
                            }
                            Text(viewModel.appetizer.description)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .opacity(0.6)
                            Spacer()
                            Button {
                                viewModel.addItemToCart()
                            } label: {
                                Text("Add To Cart")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                                    .background(Color("appColor2"))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(30)
                            }
                            .padding(.bottom, 15)
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, -150)
                    }
                } .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: btnMenu)
    }
}

struct AppetizerDetail_Previews: PreviewProvider {
    
    static let order = Order()
    static var previews: some View {
        AppetizerDetail(viewModel: AppetizerDetailViewModel(order: order, appetizer: MockData.sampleAppetizer)).environmentObject(order)
    }
}

struct ItemDetailView: View {
    
    var imageName = ""
    var textString = ""
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30, alignment: .center)
        Text(textString)
            .font(.system(size: 18, weight: .semibold, design: .default))
    }
}

struct ItemCountView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 140, height: 50)
                .cornerRadius(25)
                .foregroundColor(Color("appColor2"))
            HStack {
                Button {
                    print("Decrement")
                } label: {
                    Text("-")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
                Spacer()
                Text("1")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                Spacer()
                Button {
                    print("Increment")
                } label: {
                    Text("+")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                }
            }.frame(width: 100, height: 50)
        }
    }
}
