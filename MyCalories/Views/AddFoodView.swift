//
//  AddFoodView.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    @State private var recipe = ""
    @State private var recipePlaceholderText = Constants.recipe
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
            Form {
                Section() {
                    TextField(Constants.foodName, text: $name)
                        .accentColor(.gray)
                    
                    VStack {
                        Text("\(Constants.calories.capitalizingFirstLetter()): \(Int(calories))")
                        Slider(value: $calories, in: 0...1000, step: 10)
                    }
                    .padding()
                    
                    ZStack {
                        if self.recipe.isEmpty {
                                TextEditor(text: $recipePlaceholderText)
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .disabled(true)
                        }
                        TextEditor(text: $recipe)
                            .font(.body)
                            .opacity(self.recipe.isEmpty ? 0.25 : 1)
                    }
                    
                    HStack {
                        Spacer()
                        Button(Constants.add) {
                            validateFields()
                        }
                        .alert(Constants.failedValidation, isPresented: $showAlert, presenting: alertMessage) {message in
                            Button(Constants.ok, role: .cancel) {}
                        } message: {message in
                            Text(message)
                        }
                        Spacer()
                    }
                }
        }
    }
    
    // Validates the fields of the form
    private func validateFields() {
        guard !name.isEmpty else {
            showAlert(message: Constants.enterName)
            return
        }
        
        guard calories > 0 else {
            showAlert(message: Constants.enterCalorie)
            return
        }
        
        guard !recipe.isEmpty else {
            showAlert(message: Constants.enterRecipe)
            return
        }
        
        DataController().addFood(name: name, calories: calories, recipe: recipe, context: managedObjContext)
        dismiss()
    }
    
    // Shows the alert message
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
