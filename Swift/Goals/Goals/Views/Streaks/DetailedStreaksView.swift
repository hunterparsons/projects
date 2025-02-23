// View for the user to see the details of the streak that they selected, also allows them to check-in for the day on the streak and deletion of the streak.

import SwiftUI
import SwiftData

struct DetailedStreakView: View {
    @Environment(StreaksData.self) private var streaksData // array for the streaks
    @Environment(\.colorScheme) var colorScheme // the currently selected color scheme
    @Environment(\.dismiss) private var dismiss // allows for closing of the view
    let streak: Streak // streak selected by user

    var body: some View {
        NavigationStack {
            VStack { // vertical stack
                content
                Spacer() // spaces out content
                if !Calendar.current.isDateInToday(streak.lastCheckIn) { // if the streaks last check in is not today then make a button to check in
                    Button(action: streak.streakUpdated) {
                        Text("Check In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom)
                } 
            }
            .navigationTitle(streak.streakName) // title of the view
            .toolbar { // top nav bar
                ToolbarItem(placement: .navigationBarLeading) { // removes streak from array and closes view
                    Button(action: { dismiss(); streaksData.removeStreak(streak: streak)}) {
                        
                        Image(systemName: "trash")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                ToolbarItem(placement: .principal) { // title of the app
                    Text("DO IT!")
                        .font(.title)
                        .italic()
                        .bold()
                        .underline(true, color: Color.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) { // closes the view
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true) // hides the default back button
    }

    var content: some View {
        return HStack(alignment: .top) { // returns content of the horizontal stack
            VStack(alignment: .leading, spacing: 16) { // vertical stack alligned to leading edge
                Text(streak.streakDescription) // text with the description of the streak
                    .font(.body)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 4) { // vertical stack on leading edge with date information
                    Text("Created On: \(streak.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // date streak was created
                    Text("Last Failed: \(streak.lastFailDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // date streak was last failed
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .frame(alignment: .leading)
                
                Spacer() // spaces out content
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
        }
    }
}
