//
//  EntryListView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 02.09.24.


import SwiftUI

struct EntryListView: View {
    @Binding var entries: [Entry]
    
    @State var showAlert = false
    @State var showAddSheet = false
    @State var newEntryName: String = ""
    @State var newEntryCalories: Int = 0
    @State var selectedEntryType: EntryType = .Drink
    @State var showEntryDetailsSheet = false
    @Binding var selection: Int
    @Binding var selectedEntry: Entry
    
    
    var body: some View {
        NavigationStack {
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
                                    entries = []
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                        Spacer()
                        
                        
                        NavigationLink(destination: AddNewEntryView(newEntryName: $newEntryName, newEntryCalories: $newEntryCalories, entries: $entries, selectedEntryType: $selectedEntryType)) {
                            
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                        
                        
                    }
                    .padding()
                    
                    if entries.isEmpty {
                        Text("No tracks logged yet.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                    } else {
                        List {
                            
                            let sortedGroupedEntries = groupedAndSortedEntriesByDate(by: entries)
                            
                            ForEach(sortedGroupedEntries, id: \.key) { (date, entriesForDate) in
                                Section(header: Text(entryDateString(from: date))) {
                                    let sortedEntriesForDate = entriesForDate.sorted { (first, next) -> Bool in
                                        first.date > next.date
                                    }
                                    
                                    ForEach(sortedEntriesForDate) { entry in
                                        NavigationLink(destination: EntryDetails(selectedEntry: $selectedEntry)) {
                                            EntryView(entry: entry)
                                        }
                                    }
                                    .onDelete { indexSet in
                                        for index in indexSet {
                                            let entryToDelete = sortedEntriesForDate[index]
                                            entries.removeAll { $0.id == entryToDelete.id }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    EntryListView(entries: .constant([
        Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450),
        Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680),
        Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date().addingTimeInterval(-86400), calories: 800),
        Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340),
        Entry(entryType: .Meal, title: "Salad with eggs", date: Date().addingTimeInterval(-172800), calories: 400)
    ]), newEntryName: "", newEntryCalories: 22, selection: .constant(1), selectedEntry: .constant(Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680)))
}
