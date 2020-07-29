//
//  TestRemindersVM.swift
//  TodayX
//
//  Created by JasonMac on 19/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RemindersHomePageVM: ObservableObject {
    
    @Published
    private var reminders: Array<String> = createAllReminders()
    
    private var counter: Int = 0
    
    var returnReminders: String {
        
        if reminders.isEmpty {
            return "There are no reminders for today"
        }
        
        let index = counterReturn()
        
        return reminders[index]

    }
    
     private func counterReturn() -> Int {
        
        let currentNumber = counter
        
        if counter < reminders.count {
            counter = currentNumber + 1
            return currentNumber
        } else {
            counter = 0
        }
        return counter
    }
    
    static func createAllReminders() -> Array<String> {
        return ["Washing", "Bills", "Coding", "Study"]
    }

}

class TestReminderViewModel {
    
    var reminder = ""
    var type = ""
    var date = Date()
    
    init(reminder: Reminders) {
        self.reminder = reminder.reminder!
        self.type = reminder.type!
        self.date = reminder.date!

    }
    
}


