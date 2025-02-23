// Class to create streak type that contains all the data necessary about a streak

import Foundation
import SwiftData

@Model
class Streak {
    var streakName: String // name of streak
    var streakDescription: String // description of streak
    var startDate: Date // date streak started
    var lastFailDate: Date // last time streak was failed
    var lastCheckIn: Date // last time user checked in
    
    // Updates streak to make last check in date the current date
    func streakUpdated() {
        lastCheckIn = Date()
    }
    
    // Checks if a streak should expire, returns true if streak should expire, false otherwise
    func shouldStreakExpire() -> Bool {
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) { // unwraps optional
            return Calendar.current.compare(lastCheckIn, to: yesterday, toGranularity: .day) == .orderedAscending // if lastCheckIn < yesterday
        }
        return false // returns false if it can't be unwrapped
    }
    
    // Resets the streak by changing the fail date to the current date and the last check in to the current date
    func resetStreak() {
        lastFailDate = Date()
        lastCheckIn = Date()
    }
    
    // Initializer for streak, sets name and description based on input, other member variables are set based on the date
    init(name: String, description: String) {
        self.startDate = Date()
        self.lastFailDate = Date()
        self.lastCheckIn = Date()
        self.streakName = name
        self.streakDescription = description
    }
}
