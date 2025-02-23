// View for users to change settings of the app

import SwiftUI
import SwiftData

// View for the settings of the app, currently just contains options for the app being in dark mode
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss // allows view to go back to last by pressing button
    @Environment(\.colorScheme) var colorScheme // for light / dark mtode
    @Environment(\.colorScheme) private var systemColorScheme // for light / dark mode
    @AppStorage("selectedTheme") private var selectedTheme: String = "Sysem" // stores the theme that the user selects
    let options = ["System", "Dark", "Light"] // options for the appearance mode
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Appearance:") // text that says appearance
                        .padding() // padding for the appearance text box
                        .font(.title2) // font given to the text
                        .fontWeight(.medium) // weight of the font text
                    Picker("Select Theme", selection: $selectedTheme) { // picker for other themes, drop down menu
                        ForEach(options, id: \.self) { option in // checks each option in the array
                            Text(option).tag(option) // text with option
                        }
                    }
                    .font(.headline) // sets dont to headline
                    .pickerStyle(MenuPickerStyle()) // gives it the style of menu picker
                    .onChange(of: selectedTheme) { applyTheme() } // when changing the theme, applies theme to views
                    .padding() // adds padding
                    
                    Spacer() // pushes text to left of screen
                }
                .preferredColorScheme(getColorScheme()) // color scheme of layout
                
                Spacer() // pushes text to top of screen
            }
            .navigationTitle("Settings") // title of view
            
            // Top nav bar
            .toolbar {
                ToolbarItem(placement: .principal) { // title of app
                    Text("DO IT!")
                        .font(.title)
                        .italic()
                        .bold()
                        .underline(true, color: Color.red)
                }
                ToolbarItem { // button to close view
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
    
    // applies theme to app
    func applyTheme() {
        _ = getColorScheme()
    }
    
    // gets the current color
    func getColorScheme() -> ColorScheme? {
        switch selectedTheme {
            case "Light": .light
            case "Dark": .dark
            default: nil
        }
    }
}

