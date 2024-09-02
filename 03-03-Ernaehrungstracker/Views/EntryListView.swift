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
    
    var body: some View {
        VStack{
            
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
                            EntryView(entry: entry)
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
            HStack{
                Spacer()
                Button {
                    entries.append(Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date(), calories: 800))
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
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
    EntryListView()
}
