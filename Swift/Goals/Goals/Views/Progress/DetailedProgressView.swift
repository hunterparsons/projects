// This view is for the user to view the details of the goal that was finished, like when it was finished and when it was set on. Also allows deletion of the goal

import SwiftUI
import SwiftData

struct DetailedProgressView: View {
    @Environment(ProgressData.self) private var progressData // array for the progressed items
    @Environment(\.colorScheme) var colorScheme // the current color scheme of the app
    @Environment(\.dismiss) private var dismiss // allows for disimissal, closing, of a view
    let finishedGoal: Goal

    var body: some View {
        let finishedGoalData = finishedGoal.getData() // the data elements of the goal that's been finished

        NavigationStack {
            VStack { // vertical stack
                content
                Spacer() // space between content and bottom of screen
            }
            .navigationTitle(finishedGoalData.name) // title of view
            .toolbar { // top nav bar
                ToolbarItem(placement: .navigationBarLeading) { // button to delete the goal from the progress array, also dismisses the view
                    Button(action: {
                        dismiss(); progressData.deleteFinishedGoal(goal: finishedGoal)
                    }) {
                        
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
                ToolbarItem(placement: .navigationBarTrailing) { // button to close the view and return to previous
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
        let finishedGoalData = finishedGoal.getData() // the data for the goal selected
        let progress: Double = finishedGoalData.target == 0 ? 0 : (finishedGoalData.progress / finishedGoalData.target) // ratio of the goals progress to the goals target
        return VStack(alignment: .leading, spacing: 16) { // returns all content within vertical stack
            Text(finishedGoalData.description) // finished goals description
                .font(.body)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) { 
                GeometryReader { geometry in // contents create a progress bar
                    ZStack(alignment: .leading) {
                        Rectangle() // bar to reach
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 10)
                            .cornerRadius(5)

                        Rectangle() // progress made toward the goal
                            .fill(Color.red)
                            .frame(width: min(geometry.size.width * CGFloat(progress), geometry.size.width), height: 10)
                            .cornerRadius(5)
                    }
                }
                .frame(height: 10)
                .padding(.horizontal)

                Text("\(String(format: "%.2f", finishedGoalData.progress)) / \(String(format: "%.2f", finishedGoalData.target))") // the progress made toward the goal separated by a '/' and then the target of the goal
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Set On: \(finishedGoalData.setDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // displays the date the goal was set on
                Text("Ended On: \(finishedGoalData.dueDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // displays the date the goal ended
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top)
    }
}
