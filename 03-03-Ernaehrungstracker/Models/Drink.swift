//
//  Drink.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 05.09.24.
//

import Foundation

struct Drink: Identifiable, Hashable{
    var date: Date = Date()
    var amount: Int
    var type: DrinkType
    var id: UUID = UUID()
}

enum DrinkType: String, CaseIterable, Identifiable {
    case Water = "Water"
    case Tea = "Tea"
    case Soda = "Soda"
    case Juice = "Juice"
    case Coffee = "Coffee"
    case Other = "Other"
    
    var id: String { self.rawValue }
}
