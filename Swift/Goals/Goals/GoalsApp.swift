// App files that sets the model container and creates the arrays used throughout the program

import SwiftUI
import SwiftData

@main
struct GoalsApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: String = "Sysem" // selected appearance time for the app
    var sharedModelContainer: ModelContainer = { // creates a variable for the model container, where elements of the app are stored for later use
        let schema = Schema([ // defines that the model will contain two entities, goals and streaks
            Goal.self,
            Streak.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) // creates constant for how to configure the model, passes in the schema and makes sure that data is stored on disk instead of memory
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration]) // trys to setup the model container
        } catch {
            fatalError("Could not create ModelContainer: \(error)") // if the container cant be setup, gives fatal error
        }
    }()

    @StateObject var progressData: ProgressData // progress array
    @StateObject var goalsData: GoalsData // goals array
    @StateObject var streaksData: StreaksData // streaks array

    init() {
        let modelContext = sharedModelContainer.mainContext
        _progressData = StateObject(wrappedValue: ProgressData(modelContext: modelContext)) // sets progressData in storage equal to the progressData object contained in modelContext
        _goalsData = StateObject(wrappedValue: GoalsData(modelContext: modelContext)) // sets goalsData in storage equal to the goalsData object contained in modelContext
        _streaksData = StateObject(wrappedValue: StreaksData(modelContext: modelContext)) // sets streaksData in storage equal to the streaksData object contained in modelContext
    }

    var body: some Scene {
        WindowGroup {
            ContentView(progressData: progressData, goalsData: goalsData, streaksData: streaksData) // calls content view
                .environment(\.modelContext, sharedModelContainer.mainContext) // passes in the model context
                .environmentObject(progressData) // passes in the progress array as environment object
                .environmentObject(goalsData) // passes in the goals array as environment object
                .environmentObject(streaksData) // passes in the streaks array as environment object
                .preferredColorScheme(getColorScheme(for: selectedTheme)) // sets user preferred color scheme
        }
        .modelContainer(sharedModelContainer)
    }
    
    // Function to return the preferred color scheme
    private func getColorScheme(for theme: String) -> ColorScheme? {
        if theme == "Light" {
            return .light
        } else if theme == "Dark" {
            return .dark
        }
        return nil
    }
}
