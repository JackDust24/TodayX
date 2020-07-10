//
//  ContentView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // For Tab Bar Selection
    @State private var selection = 0
    // For Getting the Information about the weather
    @State var showSearchField: Bool = false
    @ObservedObject var forecastViewModel: APIViewModel
    @ObservedObject var reminderListVM: ReminderListVM
    
    //    @ObservedObject var testReminder: RemindersHomePageVM
    
    
    init() {
        print("Content View init")
        self.forecastViewModel = APIViewModel()
        self.reminderListVM = ReminderListVM()
    }
    
    
    var body: some View {
        TabView(selection: $selection){
            //            Text("Home View")
            //                .font(.title)
            
            ZStack(alignment: .top) {
                // Background Colour (we will change)
                
                BackgroundView()
                
                VStack {
                    // This shows the top area for doing a seach
                    TopView(forecastViewModel: self.forecastViewModel).layoutPriority(100)
                    //Spacer()
                    
                    TopAreaView(showField: self.showSearchField, forecastViewModel: self.forecastViewModel)
                    
                    Spacer()
                    //  SpacetestReminder: TestRemindersVMr()
                    
                    //                    BottomAreaView(reminderListVM: self.reminderListVM)
                    BottomAreaView()
                    
                }
            }
            .tabItem {
                VStack {
                    Image("first")
                    Text("Home")
                }
            }
            .tag(0)
            //            Text("Checklist View")
            //                .font(.title)
            RemindersView()
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Reminders")
                    }
            }
            .tag(1)
            SettingsView()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Settings")
                    }
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
