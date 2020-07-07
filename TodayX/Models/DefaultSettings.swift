//
//  DefaultSettings.swift
//  TodayX
//
//  Created by JasonMac on 7/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

struct LocationSet {
    var cityName: String
    
    func setLocationName() {
        UserDefaults.standard.set(cityName, forKey: "City")
        
    }
    
    func retrieveLocationName() -> String? {
        let storedCity : String? = UserDefaults.standard.object(forKey: "City") as? String
        return storedCity ?? nil
    }
}
