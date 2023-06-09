//
//  Route.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    
    var description: String {
        switch self {
        case .fetchAllCategories:
            return "/dish-categories"
        }
    }
}
