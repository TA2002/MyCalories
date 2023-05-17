//
//  DataModel.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "MyCalories")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully.")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addFood(name: String, calories: Double, recipe: String, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        food.recipe = recipe
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Double, recipe: String, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        food.recipe = recipe
        
        save(context: context)
    }
}
