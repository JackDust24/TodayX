//
//  APIViewModel.swift Formerly WeatherForecastVM
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI
import Combine
// TODO: What is Combine?

//
let notification = NotificationCenter.default

//TODO:- May not need this now
var arrayOfIAQIs = [Any]()

class APIViewModel: ObservableObject {
    
    // Invoke the Networks
    var weatherService: WeatherService!
    var aqiService: AQIService!
    
    //This is called to do searches
    var cityName: String = ""
    
    @Published var weatherResponse: ForecastWeatherResponse?
    @Published var aqiResponse: AQIIndexResponse?
    
    init() {
        self.weatherService = WeatherService()
        self.aqiService = AQIService()
    }
    
    //MARK: Weather Forecast Properties
    // We need this to get the city
    var currentCity: String  {
        
        if let city = self.weatherResponse?.name {
            return city
        } else {
            return "Choose City"
        }
    }
    
    // The current country
    var currentCountry: String {
        if let country = self.weatherResponse?.sys?.country {
            return country
        } else {
            return "Use Search Bar"
        }
    }
    
    // TODO:- Can delete this I expect
    var weatherDescription: String {
        if let description = self.weatherResponse?.weather?.description {
            let formattedDesc = description.capitalized(with: .current)
            return formattedDesc
        }else {
            return ""
        }
    }
    
    // The current temp
    var temperature: String {
        if let temp = self.weatherResponse?.main?.temp {
            let formattedString = String(format: "%.0f", temp)
            return formattedString + "°"
        }else {
            return "Not Set"
        }
    }
    
    // Today's date TODO:- May not need this now - so we will need to update CityDetails View
    var weatherDay: String {
        let formattedDay = Helper().getCurrentDate()
        return formattedDay
        
    }
    
    // Search City
    func searchCity() {
        
        if self.cityName == "" {
            // Check Defaults
            // Check Defaults
            print("Check Defaults")
            checkForDefaultLocation()
        }
        checkIfToSaveLocation()
        let city = self.cityName
        fetchWeatherForecast(by: city)
        fetchAQIIndex(by: city)
        
    }
    
    func checkForDefaultLocation() {
        let cityStored = retrieveLocationNameFromUserDefaults()
        
        if let storedCity = cityStored {
            self.cityName = storedCity
            print("Loading Default")
            
        }
    }
    
    func checkIfToSaveLocation() {
        print("checkIfToSaveLocation")
        
        if self.cityName != "" {
            // Check Defaults
            let cityStored = retrieveLocationNameFromUserDefaults()
            
            if let storedCity = cityStored {
                //                self.cityName = storedCity
                print("TO DO - See if user wants to change location")
                print(storedCity)
            } else {
                print("SaveLocation")
                
                setLocationNameFromUserDefaults(set: cityName)
            }
            
            
        }
        
    }
    
    // Fetch Weather Forecast
    func fetchWeatherForecast(by city: String) {
        
        //TODO: - DO we need this on another queue?
        self.weatherService.getWeatherForecast(matching: city) {
            forecast in
            DispatchQueue.main.async {
                
                if let forecast = forecast {
                    self.weatherResponse = forecast
                    
                } else {
                    print("No Response")
                    notification.post(name: Notification.Name("NoResponse"), object: nil)
                }
            }
        }
    }
    
    //MARK: AQI API Call and properties
    var aqiData: String {
        
        if let temp = self.aqiResponse?.data?.aqi {
            let formattedString = "\(temp)"
            return formattedString
        } else {
            return "Not Set"
        }
    }
    // AQI has a status
    var aqiConcernLevel: String {
        if let temp = self.aqiResponse?.data?.aqi {
            let concernLevel = returnAQIConcernLevel(for: temp)
            return concernLevel
        } else {
            return ""
        }
    }
    
    func returnAQIConcernLevel(for aqi: Int) -> String {
        
        switch aqi {
        case 0...50:
            return "Good"
        case 51...100:
            return "Moderate"
        case 101...150:
            return "Unhealthy for Sensitive Groups"
        case 151...200:
            return "Unhealthy"
        case 201...300:
            return "Very Unhealthy"
        case 301...:
            return "Hazardous"
        default:
            return "Good"
        }
    }
    
    // TODO: Try getting this on a different background queue.
    func fetchAQIIndex(by city: String) {
        
        self.aqiService.getAQIIndex(matching: city) {
            aqiIndex in
            if let aqiIndex = aqiIndex {
                DispatchQueue.main.async {
                    self.aqiResponse = aqiIndex
                    notification.post(name: Notification.Name("ResponseFromAQIAPI"), object: nil)
                }
            }
        }
    }
    
    //TODO: May not decide to use this population of AQI Index results
    var populateTheIAQI: Array<AQIObjects> {
        
        arrayOfIAQIs = []
        
        if let temp = self.aqiResponse?.data?.iaqi?.pm10?.v {
            
            let type = "PM10"
            let formattedString = "\(temp)"
            let pm10 = AQIObjects.init(type: type, value: formattedString)
            arrayOfIAQIs.append(pm10)
        }
        
        if let temp = self.aqiResponse?.data?.iaqi?.co?.v {
            let type = "Carbon Monoxide (co)"
            let formattedString = "\(temp)"
            let co = AQIObjects.init(type: type, value: formattedString)
            arrayOfIAQIs.append(co)
            
        }
        
        if let temp = self.aqiResponse?.data?.iaqi?.so2?.v {
            let type = "Sulfur Dioxide (so2)"
            let formattedString = "\(temp)"
            let so2 = AQIObjects.init(type: type, value: formattedString)
            arrayOfIAQIs.append(so2)
        }
        
        if let temp = self.aqiResponse?.data?.iaqi?.no2?.v {
            let type = "Nitrogen Dioxide (no2)"
            let formattedString = "\(temp)"
            let no2 = AQIObjects.init(type: type, value: formattedString)
            arrayOfIAQIs.append(no2)
        }
        
        if let temp = self.aqiResponse?.data?.iaqi?.o3?.v {
            let type = "Ozone (o3)"
            let formattedString = "\(temp)"
            let o3 = AQIObjects.init(type: type, value: formattedString)
            arrayOfIAQIs.append(o3)
        }
        print("CHECK ARRAY - \(arrayOfIAQIs)")
        
        return arrayOfIAQIs as! Array<AQIObjects>
        
    }
    
}

