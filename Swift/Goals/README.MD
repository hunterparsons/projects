# Goals App

## Overview
iOS app programmed in Swift that allows user to set goals for them to complete. Upon completion of a goal, the goal goes to the progress chart so users can see how far they've come. Users can also set streaks in the app to build daily habits.

## Features
### Goal Management
- Easily create and delete goals
- Track progress on goals
- Expired or completed goals will automatically be moved to the progress section
### Streak Management
- Easily create and delete streaks
- Streaks not completed will automatically reset
### Other
- Supports switching between light and dark mode
- Saves to device locally
- Custom GUI to enhance user experience

## Requirements
- xCode 15 or higher
- macOS 14.0 or higher 
- iOS 17.0 or higher if running on iPhone

## Usage
1. Build application on Mac and either run simulator or run it on iPhone
2. The bottom navigation bar allows user to switch between 3 views, the goals view, the streaks view, and the progress view
    1. The goals view contains a button to add a goal in the top right, clicking it can allow you to make a goal
        - If needed, user can update the progress on the goal by clicking on it and then clicking the bottom "Add Progress" button
    2. The Streaks view contains a button to add a streak in the top right, clicking it allows user to make a streak.
        - After creating the streak, the user does not need to check in for the first day, as it was just created
        - Each day, the "Check-In" button can be found, clicking it updates the streak to add another day
        - User can view more information on the streak by clicking on it, the detailed view also contains a button to check-in
    3. The Progress view contains no special buttons, and will display finished goals
3. Each of the main views contains a settings button in the top left, clicking this allows the user to change the appearance of the app.
