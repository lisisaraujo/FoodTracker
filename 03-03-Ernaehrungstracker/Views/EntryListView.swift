//
//  EntryListView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 02.09.24.


import SwiftUI

struct EntryListView: View {
    @State var entries: [Entry] = [
        Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450),
        Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680),
        Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date().addingTimeInterval(-86400), calories: 800),
        Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340),
        Entry(entryType: .Meal, title: "Salad with eggs", date: Date().addingTimeInterval(-172800), calories: 400)
    ]
    
    @State var showAlert = false
    @State var showAddSheet = false
    @State var newEntryName: String = ""
    @State var newEntryCalories: Int = 0
    @State var selectedEntryType: EntryType = .Drink
    @State var showEntryDetailsSheet = false
    @State var selectedEntry: Entry?
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("Delete All") {
                    showAlert = true
                }
                .tint(.red)
                .alert(isPresented:$showAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete this?"),
                        message: Text("There is no undo"),
                        primaryButton: .destructive(Text("Delete")) {
                            entries = []
                        },
                        secondaryButton: .cancel()
                    )
                }
            }.padding()
            
            if entries.isEmpty {
                
                Text("No tracks logged yet.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
            } else {
                
                List {
                    //group entries by date, so that we have all entries created on the same date under the same section, without considering the time of criation
                    let groupedEntries = Dictionary(grouping: entries) { entry -> Date in
                        let calendar = Calendar.current
                        return calendar.startOfDay(for: entry.date)
                    }
                    
                    //sort our groupEtries not by descending order (date only based)
                    let sortedGroupedEntries = groupedEntries.sorted { (first, next) -> Bool in
                        first.key > next.key
                    }
                    
                    ForEach(sortedGroupedEntries, id: \.key) { (date, entriesForDate) in
                        Section(header: Text(entryDateString(from: date))) {
                            //sort entries within the same date section by time of creation
                            let sortedEntriesForDate = entriesForDate.sorted { (first, next) -> Bool in
                                first.date > next.date
                            }
                            
                            ForEach(sortedEntriesForDate) { entry in
                                EntryView(entry: entry, action: {
                                    showEntryDetailsSheet = true
                                    selectedEntry = entry
                                })
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
            HStack{
                Spacer()
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
                
        
                .sheet(isPresented: $showAddSheet) {
                    AddNewEntryView(showAddSheet: $showAddSheet, newEntryName: $newEntryName, newEntryCalories: $newEntryCalories, entries: $entries, selectedEntryType: $selectedEntryType)
                }
            
                .sheet(isPresented: $showEntryDetailsSheet) {
                         if selectedEntry != nil{
                             EntryDetails(entry: selectedEntry!)
                         }
                     }
            }
            
        }
        
    }
    
    private func entryDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    EntryListView(newEntryName: "", newEntryCalories: 22)
}
