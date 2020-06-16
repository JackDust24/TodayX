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
    
    init() {
        fetchAllReminders()
    }
    
    func deleteReminder(_ reminderVM: ReminderViewModel) {
        CoreDataManager.shared.deleteReminder(reminder: reminderVM.reminder)
        fetchAllReminders()

    }
    
    func fetchAllReminders() {
        self.reminders = CoreDataManager.shared.getAllReminders().map(ReminderViewModel.init)
        print(self.reminders)
    }

}

class ReminderViewModel {
    
    var reminder = ""
    var type = ""
    var date = Date()
    
    init(reminder: Reminders) {
        self.reminder = reminder.reminder!
        self.type = reminder.type!
        self.date = reminder.date!

    }
    
}


