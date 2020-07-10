//
//  DefaultSettings.swift
//  TodayX
//
//  Created by JasonMac on 7/7/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation

//struct LocationSet {
//
////    func setLocationName(set city: String) {
////        UserDefaults.standard.set(city, forKey: "City")
////
////    }
//
//    func retrieveLocationName() -> String? {
//        let storedCity : String? = UserDefaults.standard.object(forKey: "City") as? String
//        return storedCity ?? nil
//    }
//}


func setLocationNameFromUserDefaults(set city: String) {
    print("setLocationNameFromUserDefaults")
    print(city)
    UserDefaults.standard.set(city, forKey: "City")
    
}

func retrieveLocationNameFromUserDefaults() -> String? {
    print("retrieveLocationNameFromUserDefaults")
    let storedCity : String? = UserDefaults.standard.object(forKey: "City") as? String
    print(storedCity as Any)

    return storedCity ?? nil
}
