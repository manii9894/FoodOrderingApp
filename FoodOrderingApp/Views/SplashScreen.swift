//
//  SplashScreen.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack {
            if !isActive {
                SplashView()
            } else {
                MainView().environmentObject(order)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isActive = true
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

struct SplashView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("bg_doodle")
                    .resizable()
                    .edgesIgnoringSafeArea(.vertical)
                    .opacity(0.25)
                VStack(spacing: 15) {
                    Image("rider")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: 180, alignment: .center)
                    Text("Al Baik")
                        .font(.system(size: 50, weight: .heavy).italic())
                        .foregroundColor(Color.red)
                }
                .padding(.bottom, 100)
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
