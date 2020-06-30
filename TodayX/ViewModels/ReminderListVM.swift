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
    
    private var counter: Int = 0
    
    init() {
        print("init ReminderListVM - do a Fetch")
        fetchAllReminders()
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
    
    func returnReminder() -> (String, Color) {
        if self.reminders.count == 0 {
            return ("There are no reminders set", Color.black)
        }
        
        print("returnReminder - \(self.reminders.count)")
//        print(self.reminders.count)

        reminders.withUnsafeBufferPointer { (point) in
            print("returnReminder - \(point)")
            // UnsafeBufferPointer(start: 0x00006000004681e0, count: 3)
        }
        
        let index = counterReturn()
        //Get string and colour to return
        let tupleToReturn = returnReminder(index: index)
        print("returnReminder - \(tupleToReturn)")

        return tupleToReturn
    }
           
    func deleteReminder(_ reminderVM: ReminderViewModel) {
        CoreDataManager.shared.deleteReminder(reminder: reminderVM.reminder)
        fetchAllReminders()
        
        
    }
    
    //                 self.reminderListVM.fetchAllReminders()

    
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
    
    private func returnReminder(index: Int) -> (String, Color) {
        
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
            // We know if the index is zero then there will be nothing imminient
            if index == 0 {
                return ("There are no reminders set for today or tomorrow.", Color.black)
            } else {
                // Otherwise we let the user know that's all.
                return ("Access the Reminders tab to see other upcoming reminders.", Color.black)
            }
        }
        
        // Get the reminder String
        let specificReminder = reminder.reminder
        print("Check specificReminder - \(specificReminder)")

        // Get the priority
        let priority = returnReminderPriority(reminder: reminder.type)
        // Make a string with the date, priority and Reminder
        let returnedStringForView = checkTheDay + priority.0 + specificReminder
        print("Check reminder - \(returnedStringForView)")
        
        return (returnedStringForView, priority.1)

    }
    
    private func returnReminderPriority(reminder: Int) -> (String, Color) {
        
        if reminder == 0 {
            return (" - URGENT - ", Color.red)
        } else if reminder == 1 {
            return (" - Important - ", Color.yellow)
        }
        return (" ", Color.black)
    }

}

struct Reminder {
    var reminder: String
    var priority: String
    var day: String
    var colour: Color
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


