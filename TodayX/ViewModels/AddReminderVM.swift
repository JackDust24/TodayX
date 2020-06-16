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
    
    var reminder: String = ""
    var type: String = ""
    var date = Date()
    
    func saveReminder() {
        CoreDataManager.shared.saveReminder(reminder: self.reminder, type: self.type, date: self.date)
    }
}
