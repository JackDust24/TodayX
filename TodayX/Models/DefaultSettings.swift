//
//  DefaultSettings.swift
//  TodayX
//
//  Created by JasonMac on 7/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

// User Defaults for Storing location
func setLocationNameFromUserDefaults(set city: String) {
    UserDefaults.standard.set(city, forKey: "City")
    
}

func retrieveLocationNameFromUserDefaults() -> String? {
    let storedCity : String? = UserDefaults.standard.object(forKey: "City") as? String
    return storedCity ?? nil
}
