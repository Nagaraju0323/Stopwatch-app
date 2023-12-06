Custom Stopwatch in SwiftUI




![Simulator Screenshot - iPhone 15 Plus - 2023-12-07 at 02 50 33](https://github.com/Nagaraju0323/Stopwatch-app/assets/97865302/1a38929a-bdac-4232-8d1e-f7b146292b9a)



![Simulator Screenshot - iPhone 15 Plus - 2023-12-07 at 02 50 43](https://github.com/Nagaraju0323/Stopwatch-app/assets/97865302/d59987a0-3dcf-443a-b162-6c977e7aea90)


Overview

I developed a custom stopwatch application using SwiftUI, providing a user-friendly and visually appealing interface. The stopwatch allows users to start, stop, and reset the timer, displaying accurate elapsed time.

Features

1. Time Display
The stopwatch features a clear and prominent display of elapsed time. I utilized SwiftUI components to create a visually appealing and easily readable format.

2. Start, Stop, and Reset Buttons
Start: Users can initiate the stopwatch, and the timer begins counting.
Stop: Pauses the stopwatch, allowing users to resume or reset.
Reset: Resets the stopwatch to zero, ready for a new timing session.
3. Interactive UI
The user interface is designed to be intuitive and responsive. Buttons change appearance based on the stopwatch's state, providing visual feedback to the user.

Implementation

1. Model
I designed a stopwatch model to manage the timer logic. It handles the start, stop, and reset functionalities, as well as keeping track of the elapsed time.

2. SwiftUI Views
StopwatchView

Displays the elapsed time.
Includes Start, Stop, and Reset buttons.
StopwatchButton

Custom button style for a consistent and visually appealing look.
3. Timer Logic
Utilizing Swift's Timer functionality to update the elapsed time at regular intervals when the stopwatch is running.

4. Animation
Incorporated smooth animations for transitioning between different states, enhancing the user experience.

