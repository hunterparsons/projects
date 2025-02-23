// View that allows user to add progress towards their goal. Takes in a goal, and gives text box for user to enter the progress they've made towards it

import SwiftUI
import SwiftData

// Need to pass goal in as a parameter
struct AddGoalProgressView: View {
    @Environment(\.dismiss) private var dismiss // used to dismiss current view
    @Environment(\.colorScheme) var colorScheme // used to check currently set color scheme
    @State var progress: String = "" // numerical progress that can be added to a goal
    let goal: Goal // the goal that the progress is being added to
    
    var body: some View {
        NavigationStack {
            VStack {
                content
            }
            .navigationTitle("Add Progress") // title for the view
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { // closes out the view
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
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
                ToolbarItem(placement: .navigationBarTrailing) { // adds the goal progress
                    Button(action: {goal.updateProgress(newProgress: progress); dismiss()}) {
                        Image(systemName: "checkmark")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    var content: some View {
        let goalData = goal.getData() // the information for the goal
        return VStack() {
            TextField("\(String(format: "%.2f", goalData.progress))", text: $progress)
                .keyboardType(.decimalPad) // sets the keyboard to only a numerical keyboard
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer() // puts space between bottom and text
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.top)
    }
}

