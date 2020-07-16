//
//  AddReminderVM.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import SwiftUI

class AddReminderVM {
    
    //MARK: Priorities
    var tag: String = "" // We want to convert the tag to a numnber. The tag is for the proorities.
    var reminder: String = ""
    var type: Int = 0
    var date = Date()
    var id = UUID()
    
    //MARK: Add Reminders
    func saveReminder() {
        // Do tag coversion first
        self.type = tagConversionToInt(from: self.tag)
        CoreDataManager.sharedContext.saveReminder(reminder: self.reminder, type: self.type, date: self.date)
    }

    
    // MARK: Edit Reminders
    func updateReminder() {
        // Do tag coversion first
        self.type = tagConversionToInt(from: self.tag)
        CoreDataManager.sharedContext.updateReminder(reminder: self.reminder, type: self.type, date: self.date, id: self.id)
    }
    
    func convertIntsToTag(from int: Int) -> String {
        if int == 2 {
            return "Urgent"
        } else if int == 1 {
            return "Important"
        } else {
            return "Normal"
        }
    }

    //MARK: Private Functions
    private func tagConversionToInt(from tag: String) -> Int {
        if tag == "urg" {
            return 0
        } else if tag == "imp" {
            return 1
        } else {
            return 2
        }
    }
}
