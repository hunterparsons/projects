// View for the countdown function apparent in the DetailedGoalsView

import SwiftUI

struct CountdownView: View {
    let targetDate: Date // The goal's due date
    @State private var timeRemaining: (days: Int, hours: Int, minutes: Int, seconds: Int) = (0, 0, 0, 0) // variable that holds time remaining
    
    var body: some View {
        Text("\(timeRemaining.days)D : \(timeRemaining.hours)H : \(timeRemaining.minutes)M : \(timeRemaining.seconds)S") // outputs the time remaining in DD:HH:MM:SS format
            .font(.title) // sets font to title
            .monospacedDigit() // sets to fixed width
            .onAppear(perform: startCountdown) // when view appears, countdown starts
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                startCountdown() // every 1 second, a second is taken of the timer
            }
    }
    
    func startCountdown() {
        let now = Date() // current date and time to compare to
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: targetDate) // difference between the times
        
        timeRemaining = (
            days: max(0, difference.day ?? 0), // days between the two dates
            hours: max(0, difference.hour ?? 0), // hours between two dates minus days
            minutes: max(0, difference.minute ?? 0), // minutes between two dates minus days and hours
            seconds: max(0, difference.second ?? 0) // seconds between two minus days, hours and minutes
        )
    }
}
