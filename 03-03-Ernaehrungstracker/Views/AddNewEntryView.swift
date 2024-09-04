//
//  NewEntrySheetView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 03.09.24.
//

import SwiftUI

struct AddNewEntryView: View {
    @Binding var newEntryName: String
    @Binding var newEntryCalories: Int
    @Binding var entries: [Entry]
    @Binding var selectedEntryType: EntryType
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Entry")) {
                    EntryTypeSelectView(selection: $selectedEntryType)
                    TextField("Title", text: $newEntryName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    TextField("Calories", value: $newEntryCalories, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                Section {
                    ButtonView(title: "Add", action: {
                        let newEntry = Entry(entryType: selectedEntryType, title: newEntryName, date: Date(), calories: newEntryCalories)
                        entries.append(newEntry)
                      
                    }, color: .blue)
                    
                    ButtonView(title: "Cancel", action: {
                       
                    }, color: .red)
                }
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddNewEntryView(newEntryName: .constant(""), newEntryCalories: .constant(0), entries: .constant([]), selectedEntryType: .constant(.Meal))
}
