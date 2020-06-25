//
//  Extensions.swift
//  TodayX
//
//  Created by JasonMac on 25/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

extension Date {
   
    init(year: Int, month: Int, day: Int) {
        var dc = DateComponents()
        dc.year = year
        dc.month = month
        dc.day = day

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        if let date = calendar.date(from: dc) {
            self.init(timeInterval: 0, since: date)
        } else {
            fatalError("Date component values were invalid.")
        }
    }

    func GetYear() -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let components = calendar.components([.day , .month , .year], from: self)
        return components.year!
    }

    func GetMonth() -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let components = calendar.components([.day , .month , .year], from: self)
        return components.month!
    }

    func GetDay() -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let components = calendar.components([.day , .month , .year], from: self)
        return components.day!
    }

}
