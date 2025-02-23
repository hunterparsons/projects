// This view is for a user to add a streak to the streaks list

import SwiftUI
import SwiftData

struct AddStreaksView: View {
    @Environment(StreaksData.self) private var streaksData // array that the streaks are held in
    @Environment(\.dismiss) private var dismiss // allows for the view to be closed
    @Environment(\.presentationMode) private var presentationMode // allows for the button to be disimissed when pressing the add streak button
    @Environment(\.colorScheme) var colorScheme // the current color scheme of the app
    @State private var newStreakTitle = "" // the title of the streak to be added
    @State private var newStreakDescription = "" // the description of the streak to be added
    
    var body: some View {
        NavigationStack {
            content
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("New Streak") // title of the view
            .toolbar { // top nav bar
                ToolbarItem(placement: .principal) { // title for the app
                    Text("DO IT!")
                        .font(.title)
                        .italic()
                        .bold()
                        .underline(true, color: Color.red)
                }
                ToolbarItem { // close button
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true) // hides the default back button
    }
    var content: some View {
        return VStack { // returns contents of the vertical stack
            TextField("Enter a streak name", text: $newStreakTitle) // area for user to enter the streaks title
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter a streak description (max 200 characters)", text: $newStreakDescription) // area for user to enter the streaks description
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: newStreakDescription) { oldValue, newValue in // when the description changes, updates the word count
                        if newValue.count > 200 {
                            newStreakDescription = String(newValue.prefix(200)) // limit to 200 characters
                        }
                    }
            
            Text("\(newStreakDescription.count)/200") // current count of characters
                .foregroundColor(newStreakDescription
                .count == 200 ? .red : .gray)
                .padding(.bottom)
            
            Button("Set Streak") { // button to add streak to the array and close the view
                let streak = Streak(name: newStreakTitle, description: newStreakDescription)
                streaksData.addStreak(streak: streak)
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
            .accentColor(.red)
        }
    }
}



