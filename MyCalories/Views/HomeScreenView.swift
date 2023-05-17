//
//  HomeScreenView.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import SwiftUI
import CoreData

struct HomeScreenView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    @ObservedObject var viewModel = HomeScreenViewModel()
    
    @State private var showingAddView = false
    @State private var selectedItem: Food?
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(Constants.popular)
                    .font(.system(size: 18))
                    .bold()
                    .padding([.horizontal])
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.dishes, id: \.id) { dish in
                            VStack(spacing: 8) {
                                AsyncImage(url: URL(string: dish.image ?? Constants.templateImage)!,
                                           placeholder: { Text(Constants.loading) },
                                           image: { Image(uiImage: $0).resizable() })
                                .frame(width: 150, height: 90)
                                Spacer()
                                Text(dish.name ?? "")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                
                                Text(dish.formattedCalories)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                
                            }
                            .frame(width: 150, height: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                    .padding([.horizontal])
                }
                .onAppear {
                    viewModel.fetchDishes()
                }
                Text("\(Int(totalCaloriesToday())) \(Constants.consumed)")
                    .foregroundColor(.gray)
                    .bold()
                    .padding()
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()

                                    Text("\(Int(food.calories))") + Text(" \(Constants.calories)").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcTimeSince(date: food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle(Constants.appName)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label(Constants.addFood, systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text(Constants.deleteItem),
                    message: Text(Constants.confirmDeletion),
                    primaryButton: .destructive(Text(Constants.delete), action: {
                        deleteSelectedItem()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationViewStyle(.stack) // Removes sidebar on iPad
    }
            
    // Deletes food at the current offset
    private func deleteFood(offsets: IndexSet) {
        selectedItem = food[offsets.first!]
        showDeleteAlert = true
    }
    
    // Deletes the selected item
    private func deleteSelectedItem() {
        guard let selectedItem = selectedItem else { return }
        
        withAnimation {
            managedObjContext.delete(selectedItem)
            
            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
    
    // Calculates the total calories consumed today
    private func totalCaloriesToday() -> Double {
        var caloriesToday : Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        print("Calories today: \(caloriesToday)")
        return caloriesToday
    }
}
