//
//  AddReminderVM.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import SwiftUI

class AddReminderVM: ObservableObject {
    
    //MARK: Priorities
    var tag: String = "" // We want to convert the tag to a numnber. The tag is for the proorities.
    var reminder: String = ""
    var type: Int = 0
    var date = Date()
    var id = UUID()
   // let characterLimit = kMaxCharsReminder
      
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
        if tag == "Urgent" {
            return 0
        } else if tag == "Important" {
            return 1
        } else {
            return 2
        }
    }
}

// For controlling a text limit for characters
class TextFieldManager: ObservableObject {
    
    let characterLimit = kMaxCharsReminder
       
    @Published var characterCount = 0
      
      @Published var userInput = "" {
          didSet {
              print("Reminder Set")
              characterCount = self.userInput.count
              print(characterCount)
              if userInput.count > kMaxCharsReminder {
                  userInput = String(userInput.prefix(kMaxCharsReminder))
              }
          }
      }
    
}

extension TextFieldManager {
    
    func isReminderValid() -> Bool {
        print(userInput)
        print(userInput.count)
        if self.userInput.count < kMinCharsReminder {
            print(userInput)
            print(userInput.count)


            print("FALSE CHECK")
            return false
        }
      
        print("TRUE CHECK")
        return true
        
    }
}
