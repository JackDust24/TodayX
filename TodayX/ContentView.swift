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
    @State private var selection = 1
    // For Getting the Information about the weather
    @State var showSearchField: Bool = false
    @State var showNewReminder: Bool = false
    // View models for Forecast and Reminders
    @ObservedObject var forecastViewModel: APIViewModel
    @ObservedObject var reminderListVM: ReminderListVM
    
    init() {
        self.forecastViewModel = APIViewModel()
        self.reminderListVM = ReminderListVM()
        
        UITabBar.appearance().backgroundColor = UIColor.init(displayP3Red: 0.475, green: 0.745, blue: 0.9333, alpha: 1.0)
        
         // for navigation bar title color
         UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        // For navigation bar background color
        UINavigationBar.appearance().backgroundColor = UIColor.init(displayP3Red: 0.475, green: 0.745, blue: 0.9333, alpha: 1.0)
    }
    
    
    var body: some View {
               
        TabView(selection: $selection){
            
            RemindersView().tabItem {
                VStack {
                    Image(TabBarImageName.tabBar0)
                        .font(.title)
                    Text("Reminders")
                }
            }.tag(0)

            ZStack(alignment: .top) {
                
                BackgroundView()
                
                VStack {
                    // This shows the top area for doing a seach
                    TopView(forecastViewModel: self.forecastViewModel).layoutPriority(100)
                    // The view showing the forecast and API
                    TopAreaView(forecastViewModel: self.forecastViewModel, reminderListVM: self.reminderListVM, showNewReminder: $showNewReminder)
                    Spacer()
                    // For showing the Reminder Bulletin
                    BottomAreaView(reminderListVM: self.reminderListVM, showNewReminder: $showNewReminder)
                    Spacer()
                }
            }.tabItem {
                VStack {
                    Image(TabBarImageName.tabBar1)
                        .font(.title)
                    Text(TabBarText.tabBar1)
                }
            }.tag(1)
            
            SettingsView(forecastViewModel: forecastViewModel).tabItem {
                VStack {
                    Image(TabBarImageName.tabBar2)
                        .font(.title)
                    Text("Info")
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
