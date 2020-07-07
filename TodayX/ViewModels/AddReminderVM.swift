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
    
    // We want to conver the tag to a numnber
    var tag: String = ""
    var reminder: String = ""
    var type: Int = 0
    var date = Date()
    var id = UUID()
    
    //MARK: Add Reminders
    func saveReminder() {
        print("SAVE REMINDER")
        // Do tag coversion first
        self.type = tagConversionToInt(from: self.tag)
        
        print(self.reminder, self.type, self.date)
        
        CoreDataManager.shared.saveReminder(reminder: self.reminder, type: self.type, date: self.date)
    }
    
    private func tagConversionToInt(from tag: String) -> Int {
        if tag == "urg" {
            return 0
        } else if tag == "imp" {
            return 1
        } else {
            return 2
        }
    }
    
    // MARK: Edit Reminders
    
    func updateReminder() {
                print("UPDATE REMINDER")
        // Do tag coversion first
        self.type = tagConversionToInt(from: self.tag)
        print(self.reminder, self.type, self.date, self.id)

        
        CoreDataManager.shared.updateReminder(reminder: self.reminder, type: self.type, date: self.date, id: self.id)
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

}
