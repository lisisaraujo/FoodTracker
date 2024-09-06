//
//  AddDailyDrinkGoal.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 06.09.24.
//

import SwiftUI

struct AddDailyDrinkGoal: View {
    @Binding var dailyGoal: DailyDrinkGoal
    @State private var goalAmount: Double = 0.0
    
    @State var sliderValue = 0.0
    @State var stepperValue = 1.0
    @State private var isEditing = false
    @Binding var dailyDrinkGoals: [DailyDrinkGoal]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set your daily drink goal")
                .font(.title)
                .padding(.top)
            
            VStack {
                Slider(
                    value: $sliderValue,
                    in: 0...5000,
                    onEditingChanged: { editing in
                        isEditing = editing
                        goalAmount = sliderValue
                    }
                )
                
                Text(String(format: "%.0f", sliderValue) + " mL")
                    .foregroundColor(isEditing ? .orange : .blue)
            }
            
            HStack {
                Text("0 mL")
                Spacer()
                Text("5000 mL")
            }
            .font(.caption)
            
            Spacer()
            Section {
                 ButtonView(title: "Add", action: {
                     let newDailyDrinkGoal = DailyDrinkGoal(date: Date(), goalAmount: goalAmount, drinks: [])
                     dailyDrinkGoals.append(newDailyDrinkGoal)
                   
                 }, color: .blue)
                 
                 ButtonView(title: "Cancel", action: {
                     
                 }, color: .red)
             }

            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddDailyDrinkGoal(dailyGoal: .constant(DailyDrinkGoal(date: Date(), goalAmount: 2000, drinks: [])), dailyDrinkGoals: .constant([DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 500, type: .Juice)]), DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 3500, type: .Water)]), DailyDrinkGoal(date: Date(), goalAmount: 3500.0, drinks: [Drink(amount: 350, type: .Tea)])]))
}
