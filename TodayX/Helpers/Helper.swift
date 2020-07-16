//
//  Helper.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

struct Helper {
    
    //MARK: Date Helpers
    func convertDateIntoString(from dateToConvert: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        //formatter.timeZone = TimeZone(identifier: "Europe/Paris")
        formatter.timeZone = TimeZone(abbreviation: "GMT+7:00")
        let dateToReturnAsString = formatter.string(from: dateToConvert)
        return dateToReturnAsString
    }
    
    // Called by WeatherForecastViewModel, for getting the day.
    func getCurrentDate() -> String {
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        return formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        
    }
    
    // When we choose a date, we don't want timestamp to appear, as this will affect the priortity listing.
    func convertDateFromPickerWithoutTime(for date: Date) -> Date {
        
        let dateToConvert = date
        let dateConverted = type(of: dateToConvert).init(year: date.GetYear(), month: date.GetMonth(), day: date.GetDay())
        return dateConverted
        
    }
    
    // Checks what day this is (called by Reminder Views)
    func checkWhatDay(for date: Date) -> String {
        // 1. Create Calendar property
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // 2. Check if today or tomorrow, if so return that string
        if calendar.isDateInToday(date) {
            return kTodayCAP
        }
        
        if calendar.isDateInTomorrow(date) {
            return kTomorrowCAP
        }
        
        // 3. Create if the date is in the past
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        // Get the string version
        let drawDate = formatDate.string(from: date)
        if let date = formatDate.date(from: drawDate) {
            
            if date < Date() {
                return kOverdueCAP
            }
        }
        
        // 4. Otherwise it will be in the future
        return "" // We return nothing as its probably in the future .
    }
    
    //MARK: Weather Helpers
    //Weather Icon for type of weather called by API
    func showWeatherIcon(item: ForecastWeatherResponse?) -> String {
        
        // In case blank return a nil
        guard item != nil else { return "cloud.sun.fill" }
        
        let main = item?.weather?.first?.main
        
        if main == nil {
            // If nil then return clear. This will probably never be called but just in case.
            return "cloud.sun.fill"
        }
        
        switch main {
        case "Ash":
            return "cloud.hail"
        case "Clear":
            return "sun.max"
        case "Clouds":
            return "cloud.sun.fill"
        case "Drizzle":
            return "cloud.drizzle.fill"
        case "Dust":
            return "sun.dust.fill"
        case "Fog":
            return "cloud.fog.fill"
        case "Haze":
            return "sun.haze.fill"
        case "Mist":
            return "cloud.drizzle"
        case "Rain":
            return "cloud.rain.fill"
        case "Sand":
            return "cloud.hail"
        case "Snow":
            return "cloud.snow.fill"
        case "Squall":
            return "cloud.hail"
        case "Thunderstorm":
            return "cloud.bol.fill"
            
        default:
            return "clear.fill"
        }
        
    }
    
    
}
