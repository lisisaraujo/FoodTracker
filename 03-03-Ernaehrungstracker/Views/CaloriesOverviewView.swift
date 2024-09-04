//
//  CaloriesOverviewView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 04.09.24.
//

import SwiftUI

struct CaloriesOverviewView: View {
    @Binding var selection: Int
    @Binding var entries: [Entry]
    
    var body: some View {
        List {
            let sortedGroupedEntries = groupedAndSortedEntriesByDate(by: entries)
            
            ForEach(sortedGroupedEntries, id: \.key) { (date, entriesForDate) in
          
                let totalCalories = entriesForDate.reduce(0) { $0 + $1.calories }
                
                Section(header: Text(entryDateString(from: date))) {
                    Text("\(totalCalories) kcal")
                        .font(.headline)
                }
            }
           
        }
        .navigationTitle("Calories Overview")
    }
}

#Preview {
    CaloriesOverviewView(selection: .constant(2), entries: .constant([
        Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450),
        Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680),
        Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date().addingTimeInterval(-86400), calories: 800),
        Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340),
        Entry(entryType: .Meal, title: "Salad with eggs", date: Date().addingTimeInterval(-172800), calories: 400)
    ]))
}
