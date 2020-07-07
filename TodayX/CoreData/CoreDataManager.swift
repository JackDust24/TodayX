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
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    // Order of State Arrays
    //TODO: Put this in the Model
    let arrayTypeOrder = ["Urgent","Important", "Normal"]
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    private func fetchReminder(reminderID: UUID) -> Reminders? {
        
        var reminders = [Reminders]()
        
        let request: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", reminderID as CVarArg)
//
//        request(entity: Reminders.entity(), sortDescriptors: [
//            NSSortDescriptor(keyPath: \Book.title, ascending: true),
//            NSSortDescriptor(keyPath: \Book.author, ascending: true)
//        ]) var books: FetchedResults<Book>
        
        do {
            reminders = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return reminders.first
    }
    

    func deleteReminder(reminderID: UUID) {
        
        do {
            if let reminder = fetchReminder(reminderID: reminderID) {
                self.moc.delete(reminder)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateReminder(reminder: String, type: Int, date: Date, id: UUID) {
        print("THE UPDATE")
        do {
            if let reminderRecord = fetchReminder(reminderID: id) {
                print("THE UPDATE2")
                reminderRecord.reminder = reminder
                reminderRecord.date = date
                reminderRecord.type = Int16(type)
                self.moc.refresh(reminderRecord, mergeChanges: true)
//                self.moc.refresh(reminder, mergeChanges: true)

               // self.moc.refresh(reminder, mergeChanges: false)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }

    func getAllReminders() -> [Reminders] {
        
        var reminders = [Reminders]()
        
        let reminderRequest: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Reminders.date), ascending: true)
        let sortByType = NSSortDescriptor(key: #keyPath(Reminders.type), ascending: true)
        reminderRequest.sortDescriptors = [sortByDate, sortByType]
        
        do {
            reminders = try self.moc.fetch(reminderRequest)
        } catch let error as NSError {
            print(error)
        }
        return reminders
       
    }
    
    func saveReminder(reminder: String, type: Int, date: Date) {
        print("saveReminder")
        let remAttribute = Reminders(context: self.moc)
        remAttribute.reminder = reminder
        remAttribute.type = Int16(type)
        remAttribute.date = date
        remAttribute.id = UUID()
        
//        print(remAttribute.reminder, remAttribute.id)
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
}
