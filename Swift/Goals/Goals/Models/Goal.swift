// Class to create goal type that contains all the data necessary about a goal

import Foundation
import SwiftData

@Model
class Goal {
    var id: UUID // ID of the goal
    var goalName: String // Name of goal
    var goalDescription: String // Description of goal
    var goalDueDate: Date // Date the goal is due
    var finishDate: Date? // Date the goal was finished, optional because it may not be finished
    var goalSetDate: Date // Date the goal was set
    var isCompleted: Bool // Whether or not the goal was complete
    var isDeleted: Bool // Whether or not the goal was deleted by the user
    var progress: Double // Progress towards the target mark
    var target: Double // The target that the user wants to reach
    
    // Checks if the user has completed the goal, returns true if the goal has been completed
    func checkIfDone() -> Bool {
        return checkForExpire() || checkProgress()
    }
    
    // Checks if the goal has expired, time had run out on it.
    private func checkForExpire() -> Bool {
        if goalDueDate < Date() {
            incomplete()
            return true
        }
        return false
    }
    
    // Checks if the user has progressed enough to finish their goal
    private func checkProgress() -> Bool {
        if progress >= target {
            complete()
            return true
        }
        return false
    }
    
    // Changes member variable of progress to the inputted progress assuming it can be converted to a double, otherwise it uses 0.0
    func updateProgress(newProgress: String) {
        progress = Double(newProgress) ?? 0.0
    }
    
    // Returns the data needed for display, used so no data is accidentally changed
    func getData() -> (name: String, description: String, dueDate: Date, setDate: Date, finishDate: Date?, isCompleted: Bool, progress: Double, target: Double) {
        return (goalName, goalDescription, goalDueDate, goalSetDate, finishDate, isCompleted, progress, target)
    }
    
    // Completes the goal, sets isCompleted to true, and changes the finish date to the current date
    func complete() {
        isCompleted = true
        finishDate = Date()
    }
    
    // Marks goal as incomplete, sets isCompleted to false, and changes the finish date to the current date
    func incomplete() {
        isCompleted = false
        finishDate = Date()
    }
    
    // Marks goal as deleted, sets isCompleted to false, and changes the finish date to the current date
    func deleted() {
        isDeleted = true
        isCompleted = false
        finishDate = Date()
    }
    
    // Initializer for goal, sets all member variables to corresponding passed in values. If the goal due date as the set date, then it will set the goal due for 11:59 PM, otherwise, just sets it for the same time on the set date.
    init(goalName: String, goalDescription: String, goalDueDate: Date, isCompleted: Bool = false, progress: String, target: String) {
        self.goalName = goalName
        self.goalDescription = goalDescription
        let calendar = Calendar.current
        if calendar.isDate(goalDueDate, equalTo: Date(), toGranularity: .day) { // if the set date is the same as the current date, compared with just day
            let components = calendar.dateComponents([.year, .month, .day], from: Date()) // date components of just the date, no time associated
            var newComponents = DateComponents()
            newComponents.year = components.year
            newComponents.month = components.month
            newComponents.day = components.day
            newComponents.hour = 23 // 11 PM
            newComponents.minute = 59 // 59 Minutes
            newComponents.second = 0 // 0 seconds
            self.goalDueDate = calendar.date(from: newComponents) ?? Date()
        } else { // if set not for the same day
            self.goalDueDate = goalDueDate
        }
        self.goalSetDate = Date()
        self.isCompleted = ((Double(progress) ?? 0.0) >= (Double(target) ?? 0.0) ? true : false) // changes strings to doubles
        self.progress = Double(progress) ?? 0.0 // changes strings to doubles
        self.target = Double(target) ?? 0.0 // changes strings to doubles
        self.id = UUID()
        self.isDeleted = false
    }
}
