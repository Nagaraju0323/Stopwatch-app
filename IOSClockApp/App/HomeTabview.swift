//
//  HomeTabview.swift
//  IOSClockApp
//
//  Created by Nagaraju on 08/12/23.
//

import SwiftUI

struct HomeTabview: View {
    init() {
           // Set the accent color to white
           UITabBar.appearance().unselectedItemTintColor = UIColor.white
       }
    var body: some View {
        TabView {
            // First Tab
            ContentView()
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("StopWatch")
                }
                .tag(0)

            // Second Tab
            DigitalView()
                .tabItem {
                    Image(systemName: "platter.top.applewatch.case")
                    Text("Timer")
                }
                .tag(1)
        }
    }
}
#Preview {
    HomeTabview()
}
