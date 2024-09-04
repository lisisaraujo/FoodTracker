
import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] = [
        Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450),
        Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680),
        Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date().addingTimeInterval(-86400), calories: 800),
        Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340),
        Entry(entryType: .Meal, title: "Salad with eggs", date: Date().addingTimeInterval(-172800), calories: 400)
    ]
    
    @State var showAlert = false
    @State var showAddSheet = false
    @State var newEntryName: String = ""
    @State var newEntryCalories: Int = 0
    @State var selectedEntryType: EntryType = .Drink
    @State var showEntryDetailsSheet = false
    @State var selectedEntry: Entry?
    
    
    
    
    var body: some View {
        
        HomeTabView(entries: $entries, selectedEntry: Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340))
    }
}


#Preview {
    ContentView()
}
