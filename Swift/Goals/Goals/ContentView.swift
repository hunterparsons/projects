// Main content view of app, compiles all views into one main one

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext // allows for saving of data
    @Environment(\.colorScheme) var colorScheme // color scheme the app is on
    @Environment(\.dismiss) var dismiss // allows for closing of views
    @ObservedObject var goalsData: GoalsData // array the goal data is held in
    @ObservedObject var progressData: ProgressData // array the progress data is held in
    @ObservedObject var streaksData: StreaksData // array the streak data is held in

    // Initializer to set member variables
    init(progressData: ProgressData, goalsData: GoalsData, streaksData: StreaksData) {
        self.progressData = progressData
        self.goalsData = goalsData
        self.streaksData = streaksData
    }

    var body: some View {
        TabView { // bottom nav bar
            GoalsView() // goals view is first option
                .environmentObject(progressData) // passes progressData in as environment object so changes can be made in GoalsView
                .environmentObject(goalsData) // passes goalsData in as environment object so changes can be made in GoalsView
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }

            StreaksView() // streaks view is second option
                .environmentObject(streaksData) // passes streaksData in as environment object so changes can be made in GoalsView
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Streaks")
                }

            ProgressView() // progress view is third option
                .environmentObject(progressData) // passes progressData in as environment object so changes can be made in GoalsView
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Progress")
                }
        }
        .accentColor(.red) // changes accents to red
    }
}

