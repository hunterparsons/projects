// View for users to see their streaks, displays all streaks within the streaks array

import SwiftUI
import SwiftData

struct StreaksView: View {
    @EnvironmentObject private var streaksData: StreaksData // streaks array
    @Environment(\.modelContext) private var modelContext // allows for saving of the elements
    @Environment(\.colorScheme) var colorScheme // currentlky selected color scheme
    @State private var timer: Timer? // timer for checking to see if a streak has expired every one second
    
    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Streaks") // title of the view
            .toolbar { // top nav bar
                ToolbarItem(placement: .navigationBarLeading) { // button to access settings
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
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
                
                ToolbarItem { // button to add another streak
                    NavigationLink(destination: AddStreaksView()) {
                        Image(systemName: "plus")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .onAppear() { // on appearance of the view, start the timer
            startTimer()
        }
        .onDisappear { // stop timer once the view dissapears
            timer?.invalidate()
        }
        .navigationBarBackButtonHidden(true) // hides the default back arrow
    }
    
    var content: some View {
        VStack { // vertical stack
            ScrollView { // makes the content scrollable
                VStack { // vertical stack
                    Divider() // horizontal line between elements to divide content
                    ForEach(streaksData.streaks, id: \.id) { streak in // iterates through each streak in the list
                        NavigationLink(destination: DetailedStreakView(streak: streak)) {
                            SubStreakView(streak: streak) // view that gives basic info on the streak
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        
                        Divider() // horizontal line between elements to divide content
                    }
                }
                .padding()
            }
        }
    }
    
    // Builds small subview for each streak
    @ViewBuilder
    func SubStreakView(streak: Streak) -> some View {
        HStack { // horizontal stack
            VStack(alignment: .leading) { // vertical stack alligned to leading edge
                Text(streak.streakName) // text with the streaks title
                    .padding(.top)
                    .font(.title2)
                    .fontWeight(.medium)
                Text(streak.streakDescription) // text with the streaks description
                if !Calendar.current.isDateInToday(streak.lastCheckIn) { // displays check in button if the last check in was not today
                    Button(action: streak.streakUpdated) {
                        Text("Check-In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .font(.headline)
                    .padding(.horizontal, 0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                } else { // puts invisible button there to keep formatting of the view right
                    Button(action: {}) {
                        Text("Check-In")
                            .foregroundColor(.clear)
                            .padding()
                            .background(Color.clear)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .disabled(true) // disables button
                }
            }
            VStack(alignment: .trailing) { // vertical stack alligned to trailing edge, contains text with the last fial date and the days the user has kept their streak going
                Text(streak.lastFailDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))
                Text("\(daysBetween(start: streak.lastFailDate, end: Date()))d")
            }
        }
    }
    
    // Function to find number of days between 2 dates
    func daysBetween(start: Date, end: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    // Function to start the timer checking in on if a streak has been completed
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [streaksData] _ in
            for streak in streaksData.streaks {
                if streak.shouldStreakExpire() {
                    streak.resetStreak()
                }
            }
        }
    }
}


