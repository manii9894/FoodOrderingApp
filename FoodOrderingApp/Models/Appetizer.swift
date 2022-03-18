//
//  Appetizer.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation

struct Appetizer: Decodable, Equatable {
    
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
    let description: String
    let calories: Int
    let carbs: Int
    let protein: Int
    
}

struct AppetizerVM: Identifiable, Equatable {
    
    let id: Int
    let appetizer: Appetizer
    
    init(appetizer: Appetizer) {
        id = appetizer.id
        self.appetizer = appetizer
    }
    
    var getName: String {
        get {
            return appetizer.name
        }
    }
    
    var getPrice: Double {
        get {
            return appetizer.price
        }
    }
    
    var getImageURL: String {
        get {
            return appetizer.imageURL
        }
    }
    
    var getDescription: String {
        get {
            return appetizer.description
        }
    }
    
    var getCalories: Int {
        get {
            return appetizer.calories
        }
    }
    
    var getCarbs: Int {
        get {
            return appetizer.carbs
        }
    }
    
    var getProtein: Int {
        get {
            return appetizer.protein
        }
    }
    
    func getPriceString() -> String {
        return String(format: "%.2f", appetizer.price)
    }
    
    
}

struct AppetizerResponse: Decodable {
    let request: [Appetizer]
}


struct MockData {
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    static let sampleAppetizer = AppetizerVM(appetizer: Appetizer(id: 0000002,
                                                                  name: "Blackened Shrimp",
                                                                  price: 6.99,
                                                                  imageURL: "https://ibb.co/qjLLHNf",
                                                                  description: "Seasoned shrimp from the depths of the Atlantic Ocean.",
                                                                  calories: 450,
                                                                  carbs: 3,
                                                                  protein: 4))
}
