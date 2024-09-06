
import SwiftUI

struct ContentView: View {
    @State var entries: [Entry] = [
        Entry(entryType: .Snack, title: "Protein Bar", date: Date(), calories: 450),
        Entry(entryType: .Meal, title: "Tapioca with cheese", date: Date(), calories: 680),
        Entry(entryType: .Meal, title: "Chickpeas with rice", date: Date().addingTimeInterval(-86400), calories: 800),
        Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340),
        Entry(entryType: .Meal, title: "Salad with eggs", date: Date().addingTimeInterval(-172800), calories: 400)
    ]
    
    @State var liquidEntries: [Drink] = [
        Drink(date: Date(), amount: 300, type: .Water),
        Drink(date: Date(), amount: 600, type: .Water),
        Drink(date: Date().addingTimeInterval(-86400), amount: 250, type: .Tea),
        Drink(date: Date().addingTimeInterval(-86400), amount: 200, type: .Juice),
        Drink(date: Date().addingTimeInterval(-86400), amount: 300, type: .Water)
    ]
    
    @State var dailyDrinkGoals: [DailyDrinkGoal] = [DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 500, type: .Juice)]), DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 3500, type: .Water)]), DailyDrinkGoal(date: Date(), goalAmount: 3500.0, drinks: [Drink(amount: 350, type: .Tea)])]
    
    @State var showAlert = false
    @State var showAddSheet = false
    @State var newEntryName: String = ""
    @State var newEntryCalories: Int = 0
    @State var selectedEntryType: EntryType = .Drink
    @State var showEntryDetailsSheet = false
    @State var selectedEntry: Entry?
    @State var liquidAmount: Int = 0

    var body: some View {
        HomeTabView(entries: $entries, liquidEntries: $liquidEntries, selectedEntry: Entry(entryType: .Meal, title: "Tomato Salad", date: Date().addingTimeInterval(-86400), calories: 340), dailyDrinkGoals: .constant([DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 500, type: .Juice)]), DailyDrinkGoal(date: Date().addingTimeInterval(-86400), goalAmount: 4500.0, drinks: [Drink(amount: 3500, type: .Water)]), DailyDrinkGoal(date: Date(), goalAmount: 3500.0, drinks: [Drink(amount: 350, type: .Tea)])]))
        }
}


#Preview {
    ContentView()
}
