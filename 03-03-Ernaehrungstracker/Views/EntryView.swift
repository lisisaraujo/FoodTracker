//
//  EntryView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 02.09.24.
//

import SwiftUI

struct EntryView: View {
    var entry: Entry
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: entry.iconImage)
                    .tint(iconColor(for: entry.entryType))
                
                Text(entry.title)
                Spacer()
                Text("\(entry.calories) kcal")
                    .font(.caption2)
            }
        }    }
    
    private func iconColor(for entryType: EntryType) -> Color {
        switch entryType {
        case .Drink:
            return .blue
        case .Meal:
            return .yellow
        case .Snack:
            return .purple
        }
    }
}

#Preview {
    EntryView(entry: Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450))
}
