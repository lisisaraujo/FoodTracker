//
//  liquidEntryView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 05.09.24.
//

import SwiftUI

struct LiquidEntryView: View {
    
    var liquidEntry: Drink
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "drop.fill")
                Text(liquidEntry.type.rawValue)
                Spacer()
                Text("\(liquidEntry.amount) ml")
                    .font(.caption2)
            }
        } 
    }
}

#Preview {
    LiquidEntryView(liquidEntry: Drink(amount: 600, type: .Water))
}
