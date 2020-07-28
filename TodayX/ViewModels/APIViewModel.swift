//
//  APIViewModel.swift Formerly WeatherForecastVM
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import SwiftUI
import Combine

let notification = NotificationCenter.default

class APIViewModel: ObservableObject {
    
    // Invoke the Networks
    var weatherService: WeatherService!
    var aqiService: AQIService!
    
    //This is called to do searches for that location
    private var cityName: String = ""
    // Computed Property so that we canupdate the cityName
    var location: String {
        get {
            cityName
        }
        
        set(newLocation) {
            cityName = newLocation
        }
    }
    
    var arrayOfIAQIs = [Any]() // Not needed for Phase 1
    
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
            return "Set City"
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
    
    // The current temp
    var temperature: String {
        if let temp = self.weatherResponse?.main?.temp {
            let formattedString = String(format: "%.0f", temp)
            return formattedString + "°"
        }else {
            return "Not Set"
        }
    }
    
    //MARK: API Reponses
    // Fetch Weather Forecast
    func fetchWeatherForecast(by city: String, userSearch userRequest: Bool) {
        print("fetchWeatherForecast")

        //TODO: - DO we need this on another queue?
        self.weatherService.getWeatherForecast(matching: city) {
            forecast in
            print("fetchWeatherForecast1")
            DispatchQueue.main.async { [unowned self] in
                
                if let forecast = forecast {
                    print("fetchWeatherForecast2")

                    self.weatherResponse = forecast
                    if userRequest {
                        NotificationCenter.default.post(name: .responseForCity, object: city)
                        // If it is the first search, set as default.
                        self.checkIfToSaveLocation()
                    }
                    
                } else if userRequest {
                    print("fetchWeatherForecast3")

                    self.cityName = ""
                    NotificationCenter.default.post(name: .noResponseForCity, object: city)
                }
            }
            print("fetchWeatherForecast4")

        }
    }
    
    // See if AQI Response and set response for user
    // TODO: Try getting this on a different background queue.
    func fetchAQIIndex(by city: String) {
        
        self.aqiService.getAQIIndex(matching: city) {
            aqiIndex in
            if let aqiIndex = aqiIndex {
                DispatchQueue.main.async {
                    self.aqiResponse = aqiIndex
                }
            }
        }
    }
    
    //MARK: Locations Functions
    // Search City called by the views to search a specific city
    // We take the paramater for userSeacrch boolean, as we want to make it clear the difference if this is a search by the user or just the page loading/reloading.
    func searchCity(userSearch userRequest: Bool ) {
        
        if self.location == "" {
            // Check if there is a default city
            checkForDefaultLocation() // If there is a default location, then we will updated the City name variable
        }
        
        // Check to see whether we store as defaults
        let city = self.cityName
        
        // We also want to send the Bool to the fetchWeatherForecast
        fetchWeatherForecast(by: city, userSearch: userRequest)
        fetchAQIIndex(by: city)
        
    }
    
    // For when we want to return the default city. Called by Info view.
    func returnDefaultCity() -> String {
        let returnCityName = returnDefaultLocation()
        return returnCityName
    }
    
    // For when we want to save the new default setting. Called by Info view.
    func saveCityLocationAsDefault(cityName: String) {
        print("Set Location 0")

        setLocationNameFromUserDefaults(set: cityName)
        
    }
    
    // MARK: Private Location functions
    private func checkForDefaultLocation() {
        
        let cityStored = retrieveLocationNameFromUserDefaults()
        
        if let storedCity = cityStored {
            print("Updating new location")
            self.location = storedCity
            
        }
    }
    
    private func returnDefaultLocation() -> String {
        
        let cityStored = retrieveLocationNameFromUserDefaults()
        
        if let storedCity = cityStored {
            return storedCity
            
        }
        return "Not Set"
    }
    
    // For when we log on first time.
    private func checkIfToSaveLocation() {
        
        if self.location != "" {
            // Check to see if default
            let cityStored = retrieveLocationNameFromUserDefaults()
            
            // If not then store the location in User Defaulys
            if cityStored == nil {
                // If the Defaults are blank we will update this as the default property/
                print("Set Location")

                setLocationNameFromUserDefaults(set: cityName)
            }
        } else {
            print("City is bogus")
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
    
    // Return Details of AQI Status
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
    
    
    //MARK: Populate other AQI results. Not in Phase 1 release.
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
        
        return arrayOfIAQIs as! Array<AQIObjects>
        
    }
    
}

