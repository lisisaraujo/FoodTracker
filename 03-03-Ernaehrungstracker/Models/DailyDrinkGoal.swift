//
//  DailyDrinkGoal.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 05.09.24.
//

import Foundation

struct DailyDrinkGoal: Identifiable, Hashable{
    var date: Date 
    var goalAmount: Double
    var drinks: [Drink]
    var id: UUID = UUID()
    
}
