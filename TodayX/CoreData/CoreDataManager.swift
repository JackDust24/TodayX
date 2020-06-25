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
    
    private func fetchReminder(reminder: String) -> Reminders? {
        
        var reminders = [Reminders]()
        
        let request: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        request.predicate = NSPredicate(format: "reminder == %@", reminder)
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
        let sortByDate = NSSortDescriptor(key: #keyPath(Reminders.date), ascending: true)
        let sortByType = NSSortDescriptor(key: #keyPath(Reminders.type), ascending: true)
//        print("JWTEST")
//        let sortTest = NSSortDescriptor(key: #keyPath(Reminders.reminder), ascending: true, comparator: { (string1 , string2) -> ComparisonResult in
//
//            guard let s1 = string1 as? String, let s2 = string2 as? String else {
//                return ComparisonResult.orderedSame
//            }
//            print("CHECK CORE")
//
//            print(s1, s2)
//
////            let s1Index = self.arrayTypeOrder.firstIndex(of: s1)!
////            let s2Index = self.arrayTypeOrder.firstIndex(of: s2)!
//
//            if s1 < s2 {
//                return ComparisonResult.orderedAscending
//            } else if s1 == s2 {
//                return ComparisonResult.orderedSame
//            } else {
//                 return ComparisonResult.orderedDescending
//            }
////            if (s1 == "Urgent" && (s2 == "Important" || s2 == "Normal"))  || s1 == "Important" || s2 == "Normal" {
////                return ComparisonResult.orderedAscending
////            } else if s1 == s2 {
////                return ComparisonResult.orderedSame
////            } else {
////                return ComparisonResult.orderedDescending
////            }
//        })


        
        reminderRequest.sortDescriptors = [sortByDate, sortByType]
        
        do {
            reminders = try self.moc.fetch(reminderRequest)
        } catch let error as NSError {
            print(error)
        }
        return reminders
       
    }
    
    func saveReminder(reminder: String, type: Int, date: Date) {
        
        let remAttribute = Reminders(context: self.moc)
        remAttribute.reminder = reminder
        remAttribute.type = Int16(type)
        remAttribute.date = date
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
}
