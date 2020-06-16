//
//  CoreDataManager.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//
// CoreDataManager for fetching and deleting etc.

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    private func fetchReminder(reminder: String) -> Reminders? {
        
        var reminders = [Reminders]()
        
        let request: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        request.predicate = NSPredicate(format: "reminder == %@", reminder)
        
        do {
            reminders = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return reminders.first
    }
    

    func deleteReminder(reminder: String) {
        
        do {
            if let reminder = fetchReminder(reminder: reminder) {
                self.moc.delete(reminder)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }

    func getAllReminders() -> [Reminders] {
        
        var reminders = [Reminders]()
        
        let reminderRequest: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        
        do {
            reminders = try self.moc.fetch(reminderRequest)
        } catch let error as NSError {
            print(error)
        }
        return reminders
       
    }
    
    func saveReminder(reminder: String, type: String, date: Date) {
        
        let remAttribute = Reminders(context: self.moc)
        remAttribute.reminder = reminder
        remAttribute.type = type
        remAttribute.date = date
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
}
