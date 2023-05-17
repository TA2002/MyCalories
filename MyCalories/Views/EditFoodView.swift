//
//  EditFoodView.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss

    var food: FetchedResults<Food>.Element

    @State private var name = ""
    @State private var calories: Double = 0
    @State private var recipe = ""
    @State private var date = Date()

    var body: some View {
        VStack {
            Form {
                Section(header: Text(Constants.addedOn)) {
                    Text("\(date, formatter: itemFormatter)")
                        .onAppear {
                            name = food.name!
                            calories = food.calories
                            recipe = food.recipe!
                            date = food.date!
                        }
                }
                
                Section(header: Text(Constants.name)) {
                    TextField("", text: $name)
                        .onAppear {
                            name = food.name!
                            calories = food.calories
                            recipe = food.recipe!
                        }
                }
                Section(header: Text(Constants.calories.capitalizingFirstLetter())) {
                    HStack {
                        Text("\(Int(calories))")
                        Slider(value: $calories, in: 0...1000, step: 10)
                    }
                }
                Section(header: Text(Constants.recipe)) {
                    TextEditor(text: $recipe)
                        .font(.body)
                }
            }
        }
        .navigationBarTitle(Constants.foodDetails)
        .background(Color.gray)
        .disabled(true)
    }
    
    // Formatter for the date
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

}
