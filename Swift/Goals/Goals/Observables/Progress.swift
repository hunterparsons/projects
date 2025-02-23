// Class to hold the progress array and member functions

import SwiftUI
import SwiftData
import Observation

@Observable
class ProgressData: ObservableObject {
    var progress: [Goal] = [] // progress array
    let modelContext: ModelContext // model progress is saved to

    // Initializer for the class, model context holds locally stored data
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchProgress()
    }
    
    // Fetches information to be transferred to progress array
    private func fetchProgress() {
        let fetchDescriptor = FetchDescriptor<Goal>()
        do {
            progress = try modelContext.fetch(fetchDescriptor).filter { $0.isCompleted }
        } catch {
            print("Error fetching goals: \(error)")
        }
    }

    // Saves the model
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }

    // Adds a finished goal to the progress array
    func addProgress(finishedGoal: Goal) {
        modelContext.insert(finishedGoal)
        progress.insert(finishedGoal, at: 0)
        save()
    }
    
    // Deletes a finished goal from the progresss array
    func deleteFinishedGoal(goal: Goal) {
        modelContext.delete(goal)
        if let index = progress.firstIndex(where: {$0.id == goal.id}) {
            progress.remove(at: index)
        }
        save()
    }
}
