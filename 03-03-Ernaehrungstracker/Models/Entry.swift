//
//  Entry.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 02.09.24.
//

import Foundation

struct Entry: Identifiable {
    let id: UUID = UUID()
    var entryType: EntryType
    var title: String
    var date: Date
    var calories: Int
    var comment: String? 
    //computed property to return the icon based on entry type
    var iconImage: String {
        switch entryType {
        case .Drink:
            return "cup.fill"
        case .Snack:
            return "hand.raised.fill"
        case .Meal:
            return "fork.knife.circle.fill"
        }
    }
    
}

enum EntryType: String, CaseIterable, Identifiable {
    case Drink = "Drink"
    case Snack = "Snack"
    case Meal = "Meal"
    
    var id: String { self.rawValue }
}
