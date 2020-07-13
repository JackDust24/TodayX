//
//  AQIService.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

class AQIService {
    
    // Key is only needed to show on this class
    fileprivate let aqiIndexKey = "af83ff8f6398a625bdae4c99ee9529c3bfc0d0c0"
    
    // Set the Base URL as we will set this ip initially.
    lazy var baseUrl: URL = {
        return URL(string: "https://api.waqi.info/feed/")!
    }()
    
    // Set up the Session and the Decoder
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    // Search function
    func getAQIIndex(matching query: String, completion: @escaping (AQIIndexResponse?) ->()){
      
        let queryString:String = query.replacingOccurrences(of: " ", with: "%20")
        
        print("getAQIIndex queryString - \(queryString)")

        
        // Make sure we can create the URL
        guard var urlComponents = URLComponents(string: "\(baseUrl)\(queryString)/") else {
                preconditionFailure("Can't create url...")
            
        }

        //TODO: - Set a default value for Query Item Units and store in Defaults
         urlComponents.queryItems = [
              URLQueryItem(name: "token", value: aqiIndexKey),
         ]
//        // Make sure we can create the URL with the added components
        guard let url = urlComponents.url else {preconditionFailure("Can't create url from url components...")}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                        
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            // get the weather response
            let aqiResponse = try? JSONDecoder().decode(AQIIndexResponse.self, from: data)
        
            // Optional Binding to see if it exists
            if let aqiResponse = aqiResponse {
               // let weather = weatherResponse.list
               
                completion(aqiResponse) //just give me the entire payload response
               // completion(weather![0]) //to get just the list
                print("AQI Response - \(aqiResponse)")
            }else {
                completion(nil)
            }
        }.resume()
    }
}

