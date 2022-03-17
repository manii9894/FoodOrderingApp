//
//  View+Extension.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
