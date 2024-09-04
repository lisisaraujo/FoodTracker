//
//  EntryTypeSelectView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 03.09.24.
//

import SwiftUI

struct EntryTypeSelectView: View {
    @Binding var selection: EntryType
    
    var body: some View {
        Picker("Type", selection: $selection) {
            ForEach(EntryType.allCases, id: \.self) { entry in
                Text(entry.rawValue).tag(entry)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    EntryTypeSelectView(selection: .constant(.Meal))
}
