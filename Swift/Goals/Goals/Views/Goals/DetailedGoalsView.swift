// View to see more details about a specific goal, takes in a goal, and shows all information stored on it

import SwiftUI
import SwiftData

struct DetailedGoalsView: View {
    @Environment(GoalsData.self) private var goalsData
    @Environment(ProgressData.self) private var progressData
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    let goal: Goal

    var body: some View {
        let goalData = goal.getData()

        NavigationStack {
            VStack { // vertical stack
                content
                Spacer() // adds space between prior elements and elements following
                NavigationLink(destination: {AddGoalProgressView(goal: goal)}) { // takes user to a screen to add progress towards the goal
                    Text("Add Progress")
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
            .navigationTitle(goalData.name) // title for the view
            
            .toolbar { // top nav view
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss(); transferToProgress(goal: goal)}) { // button to delete the goal from the array
                        Image(systemName: "trash")
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
                ToolbarItem(placement: .navigationBarTrailing) { // button to close this view and go back to prior
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true) // hides default back button
    }

    var content: some View {
        let goalData = goal.getData() // gets the data for the goal that user has selected
        let progress: Double = goalData.target == 0 ? 0 : (goalData.progress / goalData.target) // percentage for the goals progress
        return VStack(alignment: .leading, spacing: 16) { // returns everything within the vertical stack
            Text(goalData.description) // writes out the description for the goal
                .font(.body)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) { // vertical stack aligned to leading edge
                GeometryReader { geometry in // contents inside create a progress bar
                    ZStack(alignment: .leading) {
                        Rectangle() // total amount to work toward
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 10)
                            .cornerRadius(5)

                        Rectangle() // total amount contributed to the goal
                            .fill(Color.red)
                            .frame(width: min(geometry.size.width * CGFloat(progress), geometry.size.width), height: 10)
                            .cornerRadius(5)
                    }
                }
                .frame(height: 10)
                .padding(.horizontal)

                Text("\(String(format: "%.2f", goalData.progress)) / \(String(format: "%.2f", goalData.target))") // text that has progress towards goal / target for the goal, with only 2 significant figures into the decimal values
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            VStack(alignment: . trailing) { // contains a live countdown
                CountdownView(targetDate: goalData.dueDate)
            }
            .font(.caption)
            .foregroundColor(.red)
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) { // vertical stack
                Text("Set On: \(goalData.setDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // date that the goal was set on
                Text("Due On: \(goalData.dueDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // date goal is due on
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .padding(.horizontal)
            
            Spacer() // spaces out elements
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top)
    }
    
    // Transfers goal to the progress array, deleting it from goals array and adding it to progress array
    func transferToProgress(goal: Goal) {
        goalsData.deleteGoal(goal: goal)
        progressData.addProgress(finishedGoal: goal)
    }
}
