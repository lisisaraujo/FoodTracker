//
//  EntrySheetView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 03.09.24.
//

import SwiftUI

struct EntryDetails: View {
    @Binding var selectedEntry: Entry
    @State private var comment: String = ""
    
    var body: some View {
        VStack {
                    Image(systemName: selectedEntry.iconImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .tint(.yellow)
                    Text(selectedEntry.title)
                        .font(.title)
                        .foregroundColor(.blue)
                    Text("Added on: \(selectedEntry.date.formatted())")
                    Text("Calories: \(selectedEntry.calories)")
            
            LazyVGrid(columns: [GridItem()]) {
                Text("Comment:")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let existingComment = selectedEntry.comment, !existingComment.isEmpty {
                    Text(existingComment)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.vertical, 10)
                } else {
                    TextField("Write a comment", text: $comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.vertical, 10)
                        .onSubmit() {
                            selectedEntry.comment = comment
                        }
                }
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            
        }.navigationTitle(selectedEntry.title)
    }
}

#Preview {
    EntryDetails(selectedEntry: .constant(Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680, comment: "Hello")))
}
