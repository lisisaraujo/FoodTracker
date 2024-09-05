//
//  AddLiquidView.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 05.09.24.
//

import SwiftUI

struct AddLiquidView: View {
    @Binding var liquidSelection: DrinkType
    @Binding var liquidEntries: [Drink]
    @State private var liquidAmountString: String = ""
    @Binding var path: NavigationPath

    var body: some View {
        Form {
            Section(header: Text("New Entry")) {
                HStack {
                    TextField("Amount", text: $liquidAmountString)
                        .keyboardType(.numberPad)
                    Spacer()
                    Picker("Type", selection: $liquidSelection) {
                        ForEach(DrinkType.allCases, id: \.self) { entry in
                            Text(entry.rawValue).tag(entry)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            
            Section {
                Button("Add") {
                    if let amount = Double(liquidAmountString), amount > 0 { 
                        let newLiquid = Drink(date: Date(), amount: Int(amount), type: liquidSelection)
                        liquidEntries.append(newLiquid)
                        path.removeLast()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Cancel") {
                    path.removeLast()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("New Entry")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddLiquidView(
        liquidSelection: .constant(.Water),
        liquidEntries: .constant([Drink(date: Date(), amount: 300, type: .Water)]), path: .constant(NavigationPath())
    )
}
