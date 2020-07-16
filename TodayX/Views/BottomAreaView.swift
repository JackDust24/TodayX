//
//  BottomAreaView.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI

struct BottomAreaView: View {
    
    //MARK: Properties
    // This is for showing the latest reminders
    @ObservedObject var reminderListVM: ReminderListVM
    // For showing the Reminder View
    @State private var showReminder: Bool = false
    
    init() {
        self.reminderListVM = ReminderListVM()
    }
    
    var body: some View {
        
        VStack {
            //MARK: Showing the button
            ZStack {
                
                Button(action: {
                    // User clicks button to show the reminder
                    self.showReminder.toggle()
                    self.reminderListVM.returnReminder()
                    
                }) {
                    
                    Image("Spiral").renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: Color(kFranceBlueColour), radius: 8, x: 9, y: 9)
                        .shadow(color: Color(kJeansBlueColour), radius: 8, x: -9, y: -9)
                }.padding()
                    .clipShape(Circle().inset(by: 6))
                    .offset(y: -180)
                    .shadow(color: Color(kFranceBlueColour), radius: 10, x: 9, y: 9)
                    .shadow(color: Color(kJeansBlueColour), radius: 10, x: -9, y: -9)
                
                RoundedRectangle(cornerRadius: 10).stroke()
                    .foregroundColor(Color("customBlue"))
                    .frame(width: UIWidth - 40, height: UIHeight / 3 - 66)
                Spacer()
                
                // MARK: Show the reminders
                VStack(alignment: .center) {
                    
                    Text("Reminders")
                        .foregroundColor(Color(kMainTextColour))
                        .font(.custom("Raleway-Medium", size: 24))
                        .bold()
                        .padding()
                    
                    Group {
                        // Reminders go through each view and we call the function as each view will be the same
                        self.showReminder ? returnViewForReminder() : returnViewForReminder()
                    }
                    
                }.offset(y: -10)
                    .padding()
            }
            
        }
        
    }

    // So we are not duplicating code will return this
    func returnViewForReminder() -> AnyView {
        
        // The view model has a counter loop that goes through all the reminders, so the code will be the same.
        return AnyView(Text("\(self.reminderListVM.summaryReminder.title ?? "")\(self.reminderListVM.summaryReminder.priority ?? "")\(self.reminderListVM.summaryReminder.reminder)")
            .frame(width: UIWidth - 40, height: 80)
            .foregroundColor(self.reminderListVM.summaryReminder.colour)
            .font(.custom("Raleway-Medium", size: 22))
            .multilineTextAlignment(.center))
        
    }
}

struct BottomAreaView_Previews: PreviewProvider {
    static var previews: some View {
        BottomAreaView()
    }
}
