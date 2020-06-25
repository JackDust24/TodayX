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
    
    func saveReminder() {
        
        // Do tag coversion first
        self.type = tagConversion(from: self.tag)
        
        CoreDataManager.shared.saveReminder(reminder: self.reminder, type: self.type, date: self.date)
    }
    
    private func tagConversion(from tag: String) -> Int {
        if tag == "urg" {
            return 0
        } else if tag == "imp" {
            return 1
        } else {
            return 2
        }
    }
}
