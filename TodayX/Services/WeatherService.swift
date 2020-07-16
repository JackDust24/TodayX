//
//  WeatherService.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

class WeatherService {
    
    // Key is only needed to show on this class
    fileprivate let openWeatherAPIKey = "a9afa3195e1c025bf183d5b156d41e4f"
    
    // Set the Base URL as we will set this ip initially.
    lazy var baseUrl: URL = {
        return URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    }()
    
    // Set up the Session and the Decoder
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    // Search function
    func getWeatherForecast(matching query: String, completion: @escaping (ForecastWeatherResponse?) ->()){
        
        // Make sure we can create the URL
        guard var urlComponents = URLComponents(string: "\(baseUrl)") else {
            preconditionFailure("Can't create url...")
            
        }
        //api.getdata..?Queries
        //TODO: - Set a default value for Query Item Units and store in Defaults
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "appid", value: openWeatherAPIKey),
            URLQueryItem(name: "units", value: "metric") //"imperial = farenheigt
        ]
        // Make sure we can create the URL with the added components
        guard let url = urlComponents.url else {preconditionFailure("Can't create url from url components...")}
        
        // Make sure this is data we can work with
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error - \(String(describing: error))")
                completion(nil)
                return
            }
            // get the weather response
            let weatherResponse = try? JSONDecoder().decode(ForecastWeatherResponse.self, from: data)
            
            // Optional Binding to see if it exists
            if let weatherResponse = weatherResponse {
                // let weather = weatherResponse.list
                
                //TODO: - We want to send through something else if nil.
                if weatherResponse.name == nil {
                    // Need to set alert
                    completion(nil)
                    
                } else {
                    completion(weatherResponse)
                    
                }
            } else {
                completion(nil)
            }
        }.resume() // Resumes the taks if suspended.
    }
}
