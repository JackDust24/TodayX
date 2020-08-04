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
    
    @Binding var showNewReminder: Bool
    
//    init() {
//        self.reminderListVM = ReminderListVM()
//
//    }
    
//    init() {
//          self.reminderListVM = ReminderListVM()
//      }
    // For showing the Reminder View
   // let showReminder: Bool
    
//    init(showReminder: Binding<Bool>, reminderListVM: ReminderListVM) {
//        self.reminderListVM = ReminderListVM()
//        self._showReminder = showReminder
//    }
    
//    @State private var showReminderPart: Bool
//
//    @Binding var showReminder: Bool {
//
//        didSet {
//            if showReminder {
//                self.reminderListVM.returnReminder()
//                print("Reminder3 - \(self.reminderListVM.summaryReminder)")
//                // Call your reset logic here
//            }
//            self.reminderListVM.returnReminder()
//            print("Reminder4 - \(self.reminderListVM.summaryReminder)")
//        }
//    }
//
//    init() {
//        self.reminderListVM = ReminderListVM()
////        self._showReminder = showReminder
//
//    }
    
    
    var body: some View {
        
//        #if DEBUG
//                print(">> CHECKS")
//        #endif
        
        VStack {
            //MARK: Showing the button
            ZStack {
                
//                Button(action: {
//                    // User clicks button to show the reminder
//                    self.showReminder.toggle()
//                    self.reminderListVM.returnReminder()
//
//                }) {
//
//                    Image("Spiral").renderingMode(.original)
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .clipShape(Circle())
//                        .padding()
//                        .shadow(color: Color(kFranceBlueColour), radius: 8, x: 9, y: 9)
//                        .shadow(color: Color(kJeansBlueColour), radius: 8, x: -9, y: -9)
//                }.padding()
//                    .clipShape(Circle().inset(by: 6))
//                    .offset(y: -UIHeight / 3.5 + 10)
//                    .shadow(color: Color(kFranceBlueColour), radius: 10, x: 9, y: 9)
//                    .shadow(color: Color(kJeansBlueColour), radius: 10, x: -9, y: -9)
//                    .accessibility(identifier: "ImageButton")
//
//                RoundedRectangle(cornerRadius: 10).stroke()
//                    .foregroundColor(Color("customBlue"))
//                    .frame(width: UIWidth - 40, height: UIHeight / 3 - 66)
                Spacer()
                
                // MARK: Show the reminders
                VStack(alignment: .center) {
                    
                    Text("Reminders")
                        .foregroundColor(Color(kMainTextColour))
                        .font(.custom("Raleway-Medium", size: 24))
                        .bold()
                        .padding()
                        .accessibility(identifier: "display")
                    
                    
//                    Text(showNewReminder ? "Hide" : "Show")
//
//                    Text("\(self.reminderListVM.reminders.count)")
//
                    
                    Group {
                        // Reminders go through each view and we call the function as each view will be the same
//                        self.showReminder ?
//                            returnViewForReminder() : returnViewForReminder()
//                       // returnViewForReminder()
//
//                        self.returnViewForReminder()
//
//
//
//
                        Text("\(self.reminderListVM.summaryReminder.title ?? "")\(self.reminderListVM.summaryReminder.priority ?? "")\(self.reminderListVM.summaryReminder.reminder)").padding()
                        .frame(width: UIWidth - 40, height: 100)
                        .foregroundColor(self.reminderListVM.summaryReminder.colour)
                        .font(.custom("Raleway-Medium", size: 22))
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)


                    }.onAppear(perform: toggleCalled)
                    
                }.offset(y: -10)
                    .padding()
            }
            
        }
        
    }

    // So we are not duplicating code will return this
    func returnViewForReminder() -> AnyView {
       
        print("UIWIDTH - \(UIHeight)")
        print(showNewReminder)
       
        print("Reminder3 - \(self.reminderListVM.summaryReminder)")
        
        // The view model has a counter loop that goes through all the reminders, so the code will be the same.
        return AnyView(Text("\(self.reminderListVM.summaryReminder.title ?? "")\(self.reminderListVM.summaryReminder.priority ?? "")\(self.reminderListVM.summaryReminder.reminder)").padding()
            .frame(width: UIWidth - 40, height: 100)
            .foregroundColor(self.reminderListVM.summaryReminder.colour)
            .font(.custom("Raleway-Medium", size: 22))
            .lineLimit(nil)
            .multilineTextAlignment(.center))
            
        
    }
    
    func toggleCalled() {
        print("Toggle")
    }
}
//
//struct BottomAreaView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomAreaView()
//    }
//}
