//
//  HomeScreenViewModel.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation
import CoreData

class HomeScreenViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published var errorOccured = false

    var errorMessage = ""
    
    func fetchDishes() {
        NetworkService.shared.fetchAllCategories { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let allDishes):
                self.dishes = allDishes.populars ?? []
                self.dishes.remove(at: 0)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
