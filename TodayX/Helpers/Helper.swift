//
//  Helper.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

struct Helper {
    
    // SO I can get the exact time
    // TODO: - I might not need this anymore
    
    /*
     func timeConverter(timeStamp: Int, isDay: Bool) -> String {
     
     let unixTimestamp = timeStamp // so we can get milliseconds!
     let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
     let dateFormatter = DateFormatter()
     dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
     dateFormatter.locale = NSLocale.current
     dateFormatter.dateFormat = isDay ? "EEEE" : "EEEE, MMM d, yyyy"
     
     return dateFormatter.string(from: date)
     
     }
     */
    
    
    
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
    
    func showWeatherIcon(item: ForecastWeatherResponse?) -> String {
        
        
       // guard item != nil else { return "clear" }
        
        let main = item?.weather?.first?.main
        
        print("Weather icon - \(String(describing: main))")
        
        
        if main == nil {
            // If nil then return clear.
            print("weather is nil")
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
    
    func convertDateFromPickerWithoutTime(for date: Date) -> Date {
       
        let dateToConvert = date
        let dateConverted = type(of: dateToConvert).init(year: date.GetYear(), month: date.GetMonth(), day: date.GetDay())
        print("Check convertDateFromPickerWithoutTime \(dateConverted)")
        return dateConverted
        
    }
    
    func checkWhatDay(for date: Date) -> String {
        // 1. Create Calendar property
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        print("Check date for checkWhatDay \(date)")
        // 2. Check if today or tomorrow, if so return that string
        if calendar.isDateInToday(date) {
            print("Check date for checkWhatDay Today")

            return "TODAY"
        }
        
        if calendar.isDateInTomorrow(date) {
            print("Check date for checkWhatDay Tomorrow")

            return "TOMORROW"
        }
        
        print("Check date for checkWhatDay Finish")

        // 3. Create if the date is in the past
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let drawDate = formatDate.string(from: date)
        
        if let date = formatDate.date(from: drawDate) {

            if date < Date() {
                return "Overdue"
            }
        }
        // 4. Otherwise it will be in the future
        return "" // We return nothing as its probably in the future .
    }
    
    
    
    
    
}
