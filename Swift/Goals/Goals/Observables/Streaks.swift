// Class to hold array of Streak type, and member functions

import SwiftUI
import SwiftData
import Observation

@Observable
class StreaksData: ObservableObject {
    var streaks: [Streak] = [] // streak array
    let modelContext: ModelContext // model streaks is saved to

    // Initializer for the class, model context holds locally stored data
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchStreaks()
    }
    
    // Fetches information to be transferred to streaks array
    private func fetchStreaks() {
        do {
            let fetchDescriptor = FetchDescriptor<Streak>()
            let streaks = try modelContext.fetch(fetchDescriptor).filter { $0.isDeleted == false }
            self.streaks = streaks
        } catch {
            print("Error fetching streaks: \(error)")
        }
    }
    
    // Saves the model
    private func save() {
        do {
            print("saved")
            try modelContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    // Adds a streak to the streaks array and the model
    func addStreak(streak: Streak) {
        streaks.insert(streak, at: 0) // added to streaks array
        modelContext.insert(streak) // added to model
        save() // saves model
    }
    
    // Removes streak from array and model
    func removeStreak(streak:Streak) {
        modelContext.delete(streak) // removes from model
        if let index = streaks.firstIndex(where: {$0.id == streak.id}) {
            streaks.remove(at: index) // removes from streak
        }
        save() // saves model
    }
    
}
