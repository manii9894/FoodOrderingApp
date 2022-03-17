//
//  Appetizer.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

struct Appetizer: Identifiable, Decodable, Equatable {
    
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
    let description: String
    let calories: Int
    let carbs: Int
    let protein: Int
    
    func getPriceString() -> String {
        return String(format: "%.2f", price)
    }
    
}

struct AppetizerResponse: Decodable {
    let request: [Appetizer]
}


struct MockData {
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    static let sampleAppetizer = Appetizer(id: 0000002,
                                           name: "Blackened Shrimp",
                                           price: 6.99,
                                           imageURL: "https://ibb.co/qjLLHNf",
                                           description: "Seasoned shrimp from the depths of the Atlantic Ocean.",
                                           calories: 450,
                                           carbs: 3,
                                           protein: 4)
}
