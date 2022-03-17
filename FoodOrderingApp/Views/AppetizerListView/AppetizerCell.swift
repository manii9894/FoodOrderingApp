//
//  AppetizerCell.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

struct AppetizerCell: View {
    
    let appetizer: Appetizer
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack() {
                Rectangle()
                    .frame(minWidth: geometry.size.width, minHeight: 200)
                    .foregroundColor(Color.gray)
                    .opacity(0.2)
                    .cornerRadius(15)
                VStack {
                    AppetizerRemoteImage(urlString: appetizer.imageURL)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: geometry.size.width, minHeight: 100)
                        .cornerRadius(8)
                    Text(appetizer.name)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .fontWeight(.medium)
                        .frame(minWidth: geometry.size.width, minHeight: 30)
                        .foregroundColor(Color(.label))
                    Text("$\(appetizer.getPriceString())")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))
                        
                }
                .padding(.bottom, 10)
            }
        }
    }
}


struct AppetizerCell_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerCell(appetizer: MockData.sampleAppetizer)
    }
}
