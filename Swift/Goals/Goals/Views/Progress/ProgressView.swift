// This view is to see all of the elements of the progress array and some basic info on them

import SwiftUI
import SwiftData

struct ProgressView: View {
    @Environment(ProgressData.self) private var progressData // array for each of the progress elements
    @Environment(\.colorScheme) var colorScheme // the color scheme set for the app

    
    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Progress") // the title of the view
            .toolbar { // the top nav bar
                ToolbarItem(placement: .navigationBarLeading) { // settings button
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
            }
        }
        .navigationBarBackButtonHidden(true) // hides the default back arrow
    }
    
    var content: some View {
        VStack { // returns all content within the vertical stack
            ScrollView { // Makes the content scrollable
                VStack {
                    Divider() // horizontal line to seperate elements
                    ForEach(progressData.progress, id: \.id) { finishedGoal in // iterates through each finished goal in the progress array
                        NavigationLink(destination: DetailedProgressView(finishedGoal: finishedGoal)) { // button that leads to more details on a finished goal
                            FinishedSubGoalView(finishedGoal: finishedGoal) // shows basic info for each finished goal
                                .padding()
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        .background(finishedGoal.isCompleted ? Color.green.opacity(0.4) : Color.red.opacity(0.4))
                        .cornerRadius(25)
                        Divider() // horizontal line to divide elements
                    }
                }
                .padding()
            }
        }
    }
    
    // Small sub view for each finished goal, contains basic information
    @ViewBuilder
    func FinishedSubGoalView(finishedGoal: Goal) -> some View {
        let finishedGoalInfo = finishedGoal.getData() // gets data on the finished goal
        let progress: Double = finishedGoalInfo.target == 0 ? 0 : (finishedGoalInfo.progress / finishedGoalInfo.target) // gets ration of the progress made towards goal and the target amount for the goal
        HStack { // horizontal stack
            VStack(alignment: .leading) { // vertical stack aligned to leading edge of screen
                Text(finishedGoalInfo.name) // text with name of the finished goal
                    .padding(.top)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text(finishedGoalInfo.description) // text with the finished goals description
                
                GeometryReader { geometry in // content within creates progress bar for the finished goal
                    ZStack(alignment: .leading) {
                        Rectangle() // amount for user to work toward, the target
                            .fill(Color.gray.opacity(0.3))
                        Rectangle() // the amount the user has currently logged
                            .fill(Color.red)
                            .frame(width: min(geometry.size.width * CGFloat(progress), geometry.size.width))
                    }
                    .frame(height: 10)
                    .cornerRadius(5)
                }
            }
            
            VStack(alignment: .trailing) { // vertical stack alligned to the trailing edge
                Text("Started on: \(finishedGoalInfo.setDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // text with the date the goal was started
                if let finishedDate = finishedGoalInfo.finishDate { // if the finish date can be unwrapped
                    Text("Ended on: \(finishedDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)))") // text with the date the goal was finished
                }
            }
            .font(.footnote)
        }
    }
    
    // Function to get the days between 2 dates
    func daysBetween(start: Date, end: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
}
