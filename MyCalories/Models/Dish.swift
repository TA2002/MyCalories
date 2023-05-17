//
//  AllDishes.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation

struct AllDishes: Codable {
    let populars: [Dish]?
}

struct Dish: Codable {
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String{
        return "\(calories ?? 0) calories"
    }
}

