//
//  ContentView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    // For Tab Bar Selection
    @State private var selection = 0
    // For Getting the Information about the weather
    @State var showSearchField: Bool = false
    // View models for Forecast and Reminders
    @ObservedObject var forecastViewModel: APIViewModel
    @ObservedObject var reminderListVM: ReminderListVM
    
    init() {
        self.forecastViewModel = APIViewModel()
        self.reminderListVM = ReminderListVM()
    }
    
    
    var body: some View {
        TabView(selection: $selection){
            
            ZStack(alignment: .top) {
                
                BackgroundView()
                
                VStack {
                    // This shows the top area for doing a seach
                    TopView(forecastViewModel: self.forecastViewModel).layoutPriority(100)
                    // The view showing the forecast and API
                    TopAreaView(forecastViewModel: self.forecastViewModel)
                    
                    Spacer()
                    // For showing the Reminder Bulletin
                    BottomAreaView()
                    
                }
            }.tabItem {
                VStack {
                    Image("first")
                    Text("Home")
                }
            }.tag(0)
            
            ZStack(alignment: .top)  {
                // BackgroundView().zIndex(2)
                RemindersView().zIndex(10)
                
            }.tabItem {
                VStack {
                    Image("second")
                    Text("Reminders")
                }
            }.tag(1)
            
            ZStack(alignment: .top)  {
                BackgroundView()
                SettingsView(forecastViewModel: forecastViewModel)
                
            }.tabItem {
                VStack {
                    Image("first")
                    Text("Settings")
                }
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
