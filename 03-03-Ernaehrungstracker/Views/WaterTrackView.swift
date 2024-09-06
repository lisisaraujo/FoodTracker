//
//  WaterTrackView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 05.09.24.
//

import SwiftUI

struct WaterTrackView: View {
    @Binding var liquidEntries: [Drink]
    @State var showAlert = false
    @State var liquidSelection: DrinkType = .Water
    @State var path = NavigationPath()
    @State private var selectedDate = Date()
    @State var dailyGoal = DailyDrinkGoal(date: Date(), goalAmount: 2000, drinks: [])
    @State var openAddDrinkGoalSheet = false
    @Binding var dailyDrinkGoals: [DailyDrinkGoal]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    HStack {
                        Button("Delete All") {
                            showAlert = true
                        }
                        .tint(.red)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Are you sure you want to delete this?"),
                                message: Text("There is no undo"),
                                primaryButton: .destructive(Text("Delete")) {
                                    liquidEntries = []
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            path.append(NavigationDestination.addLiquid)
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                        
                        Button("Add Daily Goal"){
                        openAddDrinkGoalSheet = true
                        }.sheet(isPresented: $openAddDrinkGoalSheet, content: {
                            AddDailyDrinkGoal(dailyGoal: $dailyGoal, dailyDrinkGoals: $dailyDrinkGoals)
                        })
                    }
                    .padding()
                    
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .padding()
                    
                    if liquidEntries.isEmpty {
                        Text("No tracks logged yet.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                    } else {
                        List {
                            let filteredEntries = liquidEntries.filter { drink in
                                Calendar.current.isDate(drink.date, inSameDayAs: selectedDate)
                            }
                            
                            ForEach(filteredEntries) { liquid in
                                Button(action: {
                                    path.append(liquid)
                                }) {
                                    LiquidEntryView(liquidEntry: liquid)
                                }
                            }
                        }
                    }
          
                }
            }
            .navigationDestination(for: Drink.self) { drink in
                LiquidEntryView(liquidEntry: drink)
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .addLiquid:
                    AddLiquidView(liquidSelection: $liquidSelection, liquidEntries: $liquidEntries, path: $path)
                }
            }
        }
    }
}


#Preview {
    WaterTrackView(liquidEntries: .constant([
        Drink(date: Date(), amount: 300, type: .Water),
        Drink(date: Date(), amount: 600, type: .Water),
        Drink(date: Date().addingTimeInterval(-86400), amount: 250, type: .Tea),
        Drink(date: Date().addingTimeInterval(-86400), amount: 200, type: .Juice),
        Drink(date: Date().addingTimeInterval(-86400), amount: 300, type: .Water)
    ]), dailyDrinkGoals: .constant([DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 500, type: .Juice)]), DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 3500, type: .Water)]), DailyDrinkGoal(date: Date(), goalAmount: 3500.0, drinks: [Drink(amount: 350, type: .Tea)])]))
}
