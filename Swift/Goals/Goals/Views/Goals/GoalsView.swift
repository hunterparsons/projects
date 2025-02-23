// View for users to see the goals within the goals array

import SwiftUI
import SwiftData

struct GoalsView: View {
    @EnvironmentObject private var goalsData: GoalsData // goals array
    @EnvironmentObject private var progressData: ProgressData // progress array
    @Environment(\.colorScheme) var colorScheme // color scheme for the app
    @State private var timer: Timer? // timer that routinely checks if a goal has expired
    
    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Goals") // title for the view
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { // button to access the settings of the app
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                ToolbarItem(placement: .principal) { // title for the app
                    Text("DO IT!")
                        .font(.title)
                        .italic()
                        .bold()
                        .underline(true, color: Color.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) { // pulls up view to add goals to the array
                    NavigationLink(destination: AddGoalsView()) {
                        Image(systemName: "plus")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .onAppear() { // starts timer on appearance of view
            startTimer()
        }
        .onDisappear { // stops timer tunning
            timer?.invalidate()
        }
        .navigationBarBackButtonHidden(true) // makes back button hide
    }
    
    var content: some View {
        VStack { // vertical stack
            ScrollView { // makes the content scrollable
                VStack { // vertical stack
                    Divider() // creates line between elements for seperation
                    ForEach(goalsData.goals, id: \.id) { goal in // iterates through each goal in the array
                        NavigationLink(destination: DetailedGoalsView(goal: goal)) {  // button to lead to the details of the goal
                            SubGoalView(goal: goal) // pulls up a view for basic info of each goal in the array
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        
                        Divider() // creates line between elements for seperation
                    }
                }
                .padding()
            }
        }
    }
    
    // Small view for each goal, displays basic information
    @ViewBuilder
    func SubGoalView(goal: Goal) -> some View {
        let goalInfo = goal.getData() // gets the data for the given goal
        let progress: Double = goalInfo.target == 0 ? 0 : (goalInfo.progress / goalInfo.target) // the ratio between the progress and the target
        HStack {
            VStack(alignment: .leading) { // vertical stack alligned to leading edge of screen
                Text(goalInfo.name)
                    .padding(.top)
                    .font(.title2)
                    .fontWeight(.medium)
                Text(goalInfo.description) // description for the goal
                GeometryReader { geometry in // contents within create a progress bar
                    ZStack(alignment: .leading) {
                        Rectangle() // total amount to work toward
                            .fill(Color.gray.opacity(0.3))
                        Rectangle() // progress currently made toward the goal
                            .fill(Color.red)
                            .frame(width: min(geometry.size.width * CGFloat(progress), geometry.size.width))
                    }
                    .frame(height: 10)
                    .cornerRadius(5)
                }
            }
            VStack(alignment: .trailing) { // vertical stack alligned to trailing edge of screen
                Text(goalInfo.dueDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits))) // shows the due date for the goal
                Text("\(daysBetween(start: Date(), end: goalInfo.dueDate))d") // shows the days remaining to complete the goal
            }
        }
    }
    
    // Starts timer to check if a goal has been completed
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [goalsData] _ in
            for goal in goalsData.goals { // iterates through each goal in array
                if goal.checkIfDone() { // if goal is done, transfer it to the progress array
                    transferToProgress(goal: goal)
                }
            }
        }
    }
    
    // Checks the days between 2 dates
    func daysBetween(start: Date, end: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    // Transfers a goal from the goals array to the progress array, indicating the goal has been expired / completed / deleted
    func transferToProgress(goal: Goal) { //
        goalsData.deleteGoal(goal: goal, deletedByUser: false) // deletes goal from goals array
        progressData.addProgress(finishedGoal: goal) // adds goal to progress array
    }
}
