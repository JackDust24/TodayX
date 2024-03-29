//
//  Extensions.swift
//  TodayX
//
//  Created by JasonMac on 25/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

//MARK: Dates
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

//MARK: Notifications
extension Notification.Name {
    static let responseForCity = Notification.Name("Response")
    static let noResponseForCity = Notification.Name("NoResponse")
    static let noResponseFromAQIIndex = Notification.Name("NoResponseAQI")
    static let noInternetConnetion = Notification.Name("NoInternet")

}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
