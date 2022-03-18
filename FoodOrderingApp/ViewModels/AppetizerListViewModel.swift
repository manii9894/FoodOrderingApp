//
//  AppetizerListViewModel.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation
import SwiftUI
import Combine

final class AppetizerViewModel: ObservableObject {
    
    @EnvironmentObject var order: Order
    @Published var appetizers: [AppetizerVM] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    private var cancellables = Set<AnyCancellable>()
    
    func getAppetizers() {
        
        isLoading = true
        NetworkManager.shared.request(endpoint: .appetizers, method: .GET, responseType: AppetizerResponse.self)
            .sink { [unowned self] completion in
                switch completion {
                case .failure(let error):
                    self.isLoading = false
                    self.alertItem = AlertContext.getAlertItem(title: "Error", message: error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { [unowned self] response in
                self.isLoading = false
                var appetizers = [AppetizerVM]()
                for obj in response.request {
                    appetizers.append(AppetizerVM(appetizer: obj))
                }
                self.appetizers = appetizers
            }.store(in: &cancellables)
        
    }
    
    func getColumns() -> [GridItem] {
        
        return [
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
        ]
        
    }
    
}
