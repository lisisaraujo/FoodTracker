//
//  Utils.swift
//  03-03-Ernaehrungstracker
//
//  Created by Lisis Ruschel on 04.09.24.
//

import Foundation



func entryDateString(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}


func groupedAndSortedEntriesByDate(by entries: [Entry]) -> [(key: Date, value: [Entry])] {
    
    //group entries by date, so that we have all entries created on the same date under the same section, without considering the time of criation
    
    let groupedEntries = Dictionary(grouping: entries) { entry -> Date in
        let calendar = Calendar.current
        return calendar.startOfDay(for: entry.date)
    }
    
    
    //sort our groupEtries not by descending order (date only based)
    return groupedEntries.sorted { (first, next) -> Bool in
        first.key > next.key
    }
}
