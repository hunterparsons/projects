// Class that holds the array of type Goal, and all member functions

import SwiftUI
import SwiftData
import Observation

@Observable
class GoalsData: ObservableObject {
    var goals: [Goal] = []
    let modelContext: ModelContext
    
    // Initializer for the class, model context holds locally stored data
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchGoals()
    }
    
    // Fetches all goals from the database
    private func fetchGoals() {
        let fetchDescriptor = FetchDescriptor<Goal>()
        do {
            goals = try modelContext.fetch(fetchDescriptor).filter { !$0.isDeleted && !$0.isCompleted }
        } catch {
            print("Error fetching goals: \(error)")
        }
    }

    // Adds elements form the goalsData array to the model
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    // Finds the insert position for the array, insert is filtered by date with the closest date being at the beginning of the array, searches binarily
    private func findInsertPos(goal: Goal) -> Int {
        if goals.isEmpty { return 0 } // returns 0 if the array is empty
        let high = goals.count - 1 // the index of the final element
        let low = 0 // first index
        let goalDate = goal.getData().dueDate // the due date of the goal to be inserted
        return findInsertPosHelper(insertDate: goalDate, low: low, high: high)
    }

    // Contains recursive logic for the findInsertPos func.
    private func findInsertPosHelper(insertDate: Date, low: Int, high: Int) -> Int {
        if high <= low { // if the 2 indexes are equal to each other, or the high index is lower
            return (insertDate > goals[low].getData().dueDate ? (low + 1) : low) // if the insert date is higher than the array at low, then insert at index low + 1, otherwise insert at low
        }
        let mid = (low + high) / 2 // index between low and high
        if insertDate == goals[mid].getData().dueDate { // if the date to be inserted is equal to the arrays due date at the middle index
            return mid + 1 // should be inserted at middle + 1
        }
        if insertDate > goals[mid].getData().dueDate { // if the insert date is higher than the arrays due date at the middle index
            return findInsertPosHelper(insertDate: insertDate, low: mid + 1, high: high)
        }
        return findInsertPosHelper(insertDate: insertDate, low: low, high: mid - 1) // else
    }
    
    // Checks to see if a goal has expired
    private func checkForExpire(goal: Goal) -> Bool {
        if goal.getData().dueDate < Date() {
            goal.incomplete() // marks goal as incomplete
            goal.deleted() // marks goal as deleted by user
            save()
            return true
        }
        return false
    }
    
    // Checks to see if a goal has progressed past it's target
    private func checkProgress(goal: Goal) -> Bool {
        let goalData = goal.getData()
        if goalData.progress >= goalData.target {
            goal.complete() // marks goal as complete
            save()
            return true
        }
        return false
    }
    
    // Adds a goal to the array
    func addGoal(goal: Goal) {
        modelContext.insert(goal)
        let insertIndex = findInsertPos(goal: goal) // gets insert index and
        goals.insert(goal, at: insertIndex)
        save()
    }
    
    // Deletes a goal from the array
    func deleteGoal(goal: Goal, deletedByUser: Bool = true) {
        if deletedByUser {
            goal.incomplete() // marks goal as incomplete
        }
        modelContext.delete(goal)
        if let index = goals.firstIndex(where: {$0.id == goal.id}) {
            goals.remove(at: index) // removes goal
        }
        save()
    }
}


