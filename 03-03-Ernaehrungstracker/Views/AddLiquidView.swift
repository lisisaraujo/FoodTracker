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
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                    ButtonView(title: "Add", action: {
                        if let amount = Int(liquidAmountString) {
                            let newLiquid = Drink(amount: amount, type: liquidSelection)
                            liquidEntries.append(newLiquid)
                        }
                    }, color: .blue)
                    
                    ButtonView(title: "Cancel", action: {
                        path.removeLast()
                    }, color: .red)
                }
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddLiquidView(liquidSelection: .constant(.Water), liquidEntries: .constant([Drink(amount: 300, type: .Water), Drink(amount: 600, type: .Water), Drink(amount: 250, type: .Tea), Drink(amount: 200, type: .Juice), Drink(amount: 300, type: .Water)]))
}
