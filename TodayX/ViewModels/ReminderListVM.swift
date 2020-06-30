//
//  ReminderListVM.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

import SwiftUI
import CoreData
import Combine

class ReminderListVM: ObservableObject {
    
    @Published
    var reminders = [ReminderViewModel]()
    
    @Published var summaryReminder =  SummaryReminder(reminder: "Press Button To See Reminders")
    
    private var counter: Int = 0
    
    init() {
        print("init ReminderListVM - do a Fetch")
        fetchAllReminders()
//        summaryReminder = self.summaryReminder
    }
    
//    var returnReminders: String {
//        
//        if reminders.count == 0 {
//            return "There are no reminders set"
//        }
//        
//        print("CHECK FETCH")
//        print(self.reminders.count)
//
//        let index = counterReturn()
//        let stringToReturn = returnReminder(index: index)
//
//        return stringToReturn
//
//    }
    
            
    func deleteReminder(_ reminderVM: ReminderViewModel) {
        CoreDataManager.shared.deleteReminder(reminder: reminderVM.reminder)
        fetchAllReminders()
       
    }
    
    func fetchAllReminders() {
        
        reminders = [] // Clear array

        self.reminders = CoreDataManager.shared.getAllReminders().map(ReminderViewModel.init)
        print("fetchAllReminders - \(self.reminders.count)")

        reminders.withUnsafeBufferPointer { (point) in
            print("fetchAllReminders - \(point)")
            // UnsafeBufferPointer(start: 0x00006000004681e0, count: 3)
        }
    }
    
    //MARK: For the Home Page
    
    func returnReminder()  {
         if self.reminders.count == 0 {
             let message = "Access the reminders tab to set"
            summaryReminder = SummaryReminder(reminder: message, priority: nil, title: "No Reminders Set", colour: nil)
            return
         }
         
         print("returnReminder - \(self.reminders.count)")
 //        print(self.reminders.count)

         reminders.withUnsafeBufferPointer { (point) in
             print("returnReminder - \(point)")
             // UnsafeBufferPointer(start: 0x00006000004681e0, count: 3)
         }
         
         let index = counterReturn()
         //Get string and colour to return
         let getReminder = returnReminder(index: index)
         print("Summary Reminer to return - \(getReminder)")

         summaryReminder = getReminder
     }
    
    
    
    
    private func counterReturn() -> Int {
           
           let currentNumber = counter
           
           if counter < reminders.count {
               counter = currentNumber + 1
               return currentNumber
           } else {
               resetCounter()
               counter += 1
           }
           return 0
       }
       
       private func resetCounter() {
        print("RESET COUNTER")
           counter = 0
       }
    
    private func returnReminder(index: Int) -> SummaryReminder {
        
        print("returnReminder1 Index Check")
        print(index)

        //1. Get the s[ecific remindern and string we will return
        let reminder = self.reminders[index]
                
        //2. Check the date
        let checkTheDay = Helper().checkWhatDay(for: reminder.date)

        //3. If the date is in the future we will see a "" returned, if this is the case, then we need to exit out of this, reset the counter and also if this is the first cycle let the Suer know there is NO reminders imminent
        if checkTheDay.isEmpty {
            print("returnReminder3")
            // Reset the counter
            resetCounter()
            var message = ""
//            var headlineMessage = ""
            // We know if the index is zero then there will be nothing imminient
            if index == 0 {
                
                message = "There are no reminders for today or tomorrow."
               
            } else {
                // Otherwise we let the user know that's all.
                message = "Access the Reminders tab to see later reminders."
            }
            
            return SummaryReminder(reminder: message, priority: nil, title: nil, colour: nil)
        }
        
        // Get the reminder String
        let specificReminder = reminder.reminder
        print("Check specificReminder - \(specificReminder)")
        
        

        // Get the priority
        let reminderPriority = returnReminderPriority(priority: reminder.type, day: checkTheDay)
        let priority = reminderPriority.0
        let color = reminderPriority.1
        
        var amendedPriority = ""

        // We want to do this to help out the view. Separate the day pointing to the priority, we will also add a new line.
        if !priority.isEmpty {
            amendedPriority = " - \(priority)\n"

        } else {
            amendedPriority = "\n"
        }
        
        let reminderToReturn = SummaryReminder(reminder: specificReminder, priority: amendedPriority, title: checkTheDay, colour: color)
        // Make a string with the date, priority and Reminder
//        let returnedStringForView = checkTheDay + priority.0 + specificReminder
        print("Check reminder to Return- \(reminderToReturn)")
        
        return reminderToReturn

    }
    
    private func returnReminderPriority(priority: Int, day: String) -> (String, Color?) {
        
        // If urgent due for today or overdue then Red.
        if priority == 0 && (day == kTodayCAP || day == kOverdueCAP) {
            return ("URGENT", Color.red)
            // If urgent due for tomorrow then Red.
        } else if priority == 0 && day == kTomorrowCAP {
            return ("URGENT", Color.blue)
        } else if priority == 1 && (day == kTodayCAP || day == kOverdueCAP) {
            return ("Important", Color.red)
        } else if priority == 1 && day == kTomorrowCAP {
            return ("Important", Color.blue)
        } else if priority >= 2 && (day == kTodayCAP || day == kOverdueCAP) {
            return ("", Color.blue)
        }
        return ("", nil)
    }

}

struct SummaryReminder {
    var reminder: String
    var priority: String?
    var title: String?
    var colour: Color?
}


class ReminderViewModel {
    
    var reminder = ""
    var type = 0
    var date = Date()
    
    init(reminder: Reminders) {
        self.reminder = reminder.reminder!
        self.type = Int(reminder.type)
        self.date = reminder.date!
        
    }
    
}


