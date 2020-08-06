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
import SwiftUI

class CoreDataManager {
    
    //MARK: Properties
    // Shared Context
    static let sharedContext = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // Delete Reminders
    func deleteReminder(reminderID: UUID) {
        
        do {
            if let reminder = fetchReminder(reminderID: reminderID) {
                self.moc.delete(reminder)
                try self.moc.save()
            }
            
        } catch let error as NSError {
            //TODO: Error Handling
            print(error)
        }
    }
    
    // Update the Reminders if edited
    func updateReminder(reminder: String, type: Int, date: Date, id: UUID) {
        
        do {
            if let reminderRecord = fetchReminder(reminderID: id) {
                reminderRecord.reminder = reminder
                reminderRecord.date = date
                reminderRecord.type = Int16(type)
                self.moc.refresh(reminderRecord, mergeChanges: true)
                
                try self.moc.save()
            }
            
        } catch let error as NSError {
            //TODO: Error Handling
            print(error)
        }
    }
    
    // Get all the reminders
    func getAllReminders() -> [Reminders] {
        print("Get all reminders")
        var reminders = [Reminders]()
        let reminderRequest: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Reminders.date), ascending: true)
        let sortByType = NSSortDescriptor(key: #keyPath(Reminders.type), ascending: true)
        reminderRequest.sortDescriptors = [sortByDate, sortByType]
        
        do {
            reminders = try self.moc.fetch(reminderRequest)
            
        } catch let error as NSError {
            //TODO: Error Handling
            print(error)
        }
        
        //print(reminders)
        return reminders
        
    }
    
    // Save Reminder that's been added
    func saveReminder(reminder: String, type: Int, date: Date) {
        
        let remAttribute = Reminders(context: self.moc)
        remAttribute.reminder = reminder
        remAttribute.type = Int16(type)
        remAttribute.date = date
        remAttribute.id = UUID()
        
        do {
            try self.moc.save()
            
        } catch let error as NSError {
            //TODO: Error Handling
            print(error)
        }
        
    }
    
    //MARK: Private Functions
    
    // Fetch all the reminders
    private func fetchReminder(reminderID: UUID) -> Reminders? {
        
        var reminders = [Reminders]()
        let request: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", reminderID as CVarArg)
        
        do {
            reminders = try self.moc.fetch(request)
            
        } catch let error as NSError {
            //TODO: Error Handling
            print(error)
        }
        
        return reminders.first
    }
}
