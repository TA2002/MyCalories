//
//  MyCaloriesApp.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import SwiftUI

@main
struct MyCaloriesApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
