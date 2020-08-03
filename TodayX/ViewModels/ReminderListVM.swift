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
    
    //TODO:= DO a computed property.
    private var counter: Int = 0
    
    init() {
        fetchAllReminders()
    }
    
    //MARK: Properties that the ReminderView can call
    // For returning the images
    func getImagesForTheType(for type: Int) -> String {
        if type == 0 {
            return "Urgent"
        } else if type == 1 {
            return "Important"
        } else {
            return "Normal"
        }
    }
   
    func deleteReminder(_ reminderVM: ReminderViewModel) {
        CoreDataManager.sharedContext.deleteReminder(reminderID: reminderVM.id)
        fetchAllReminders()
    }
    
    func fetchAllReminders() {
        
        reminders = [] // Clear array
        self.reminders = CoreDataManager.sharedContext.getAllReminders().map(ReminderViewModel.init)
        
        //TODO:= Debugging can remove.
        reminders.withUnsafeBufferPointer { (point) in
            print("fetchAllReminders - \(point)")
        }
    }
    
    //MARK: For the Home Page
    func returnReminder()  {
        if self.reminders.count == 0 {
            let message = "Access the reminders tab to set."
            summaryReminder = SummaryReminder(reminder: message, priority: nil, title: "No Reminders Set\n", colour: nil)
            return
        }
        
        //TODO:= Debugging can remove.
        reminders.withUnsafeBufferPointer { (point) in
            print("returnReminder - \(point)")
            // UnsafeBufferPointer(start: 0x00006000004681e0, count: 3)
        }
        
        let index = counterReturn()
        //Get string and colour to return
        let getReminder = returnReminder(index: index)
        summaryReminder = getReminder
    }
    
    // The counter loops to return all the reminders.
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
        counter = 0
    }
    
    private func returnReminder(index: Int) -> SummaryReminder {
        
        //1. Get the s[ecific remindern and string we will return
        let reminder = self.reminders[index]
        
        //2. Check the date
        let checkTheDay = Helper().checkWhatDay(for: reminder.date)
        
        //3. If the date is in the future we will see a "" returned, if this is the case, then we need to exit out of this, reset the counter and also if this is the first cycle let the Suer know there is NO reminders imminent
        if checkTheDay.isEmpty {
            // Reset the counter
            resetCounter()
            var message = ""
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
        
        // Make a string with the date, priority and Reminder
        let reminderToReturn = SummaryReminder(reminder: specificReminder, priority: amendedPriority, title: checkTheDay, colour: color)
       
        return reminderToReturn
    }
    
    // Returning different colour text depending on priority and date.
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

// Summary Reminder for the Home page
struct SummaryReminder {
    var reminder: String
    var priority: String?
    var title: String?
    var colour: Color?
}

// The Reminder object which we will store in Core Data
class ReminderViewModel {
    
    var reminder = ""
    var type = 0
    var date = Date()
    var id = UUID()
    
    init(reminder: Reminders) {
        self.reminder = reminder.reminder!
        self.type = Int(reminder.type)
        self.date = reminder.date!
        self.id = reminder.id!
    }
    
}


