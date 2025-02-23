// View that allows user to add a goal to the goals array

import SwiftUI
import SwiftData

struct AddGoalsView: View {
    @Environment(GoalsData.self) private var goalsData // array for the goals
    @Environment(\.dismiss) private var dismiss // used to close out of the view
    @Environment(\.colorScheme) var colorScheme // used to check set color scheme of the app
    @Environment(\.presentationMode) private var presentationMode // used so the set goal button can dismiss the view
    @State private var newGoalTitle = "" // the name of the goal to be set
    @State private var newGoalDescription = "" // the description of the goal to be set
    @State private var goalAmount = "" // the target of the goal to be set
    @State private var currentAmount = "" // the current amount contributed to the goal to be set
    @State private var selectedDate: Date = Date() // the date of the goal to be set
    
    var body: some View {
        NavigationStack {
            content
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("New Goal") // title for the view
            
            .toolbar { // the top nav bar
                ToolbarItem(placement: .principal) { // title of the app
                    Text("DO IT!")
                        .font(.title)
                        .italic()
                        .bold()
                        .underline(true, color: Color.red)
                }
                ToolbarItem { // used to close out the view
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    var content: some View {
        VStack { // vertical stack
            TextField("Enter a goal name", text: $newGoalTitle) // entry field for the title of th goal
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
            TextField("Enter a goal description (max 200 characters)", text: $newGoalDescription) // entry field for the description of the goal
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: newGoalDescription) { oldValue, newValue in
                    if newValue.count > 200 {
                        newGoalDescription = String(newValue.prefix(200)) // limit to 200 characters
                    }
                }
            Text("\(newGoalDescription.count)/200") // counts the character amount user is currently on
                .foregroundColor(newGoalDescription
                .count == 200 ? .red : .gray)
                .padding(.bottom)
            
            TextField("Enter a goal target", text: $goalAmount) // entry field for the target of the goal
                .keyboardType(.decimalPad) // restricts keyboard to just numbers
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter current amount", text: $currentAmount) // entry field for the current amount contributed towards the goal
                .keyboardType(.decimalPad) // restricts keyboard to just numbers
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker ( // date selector for the goals due date
                "Select a Due Date",
                selection: $selectedDate,
                // restricts time frame to 100 years into the future
                in:  Date()...Date().addingTimeInterval(60*60*24*365*100),
                // displays date
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .padding()

            Button("Set Goal") { // adds the goal to the array and closes out the view
                let goal = Goal(goalName: newGoalTitle, goalDescription: newGoalDescription, goalDueDate: selectedDate, progress: currentAmount, target: goalAmount)
                goalsData.addGoal(goal: goal)
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
            .accentColor(.red)
        }
    }
}
