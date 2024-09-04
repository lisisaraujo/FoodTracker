//
//  HomeTabView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 04.09.24.
//

import SwiftUI

struct HomeTabView: View {
    
    
    @State var selection: Int = 1
    @Binding var entries: [Entry]
    @State var selectedEntry: Entry

    
    var body: some View {
        TabView(selection: $selection) {
            EntryListView(entries: $entries, selection: $selection, selectedEntry: $selectedEntry)
                .tabItem {
                    Label("Tracks", systemImage: "list.bullet.clipboard.fill")
                }
                .tag(1)
            
            CaloriesOverviewView(selection: $selection, entries: $entries)
                .tabItem {
                    Label("Calories", systemImage: "flame.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    HomeTabView(entries: .constant([
        Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450),
        Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680),
        Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date().addingTimeInterval(-86400), calories: 800),
        Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340),
        Entry(entryType: .Meal, title: "Salad with eggs", date: Date().addingTimeInterval(-172800), calories: 400)
    ]), selectedEntry: Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340))
}
