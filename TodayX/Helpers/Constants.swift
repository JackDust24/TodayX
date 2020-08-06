//
//  Constants.swift
//  TodayX
//
//  Created by JasonMac on 30/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import SwiftUI

// Reminders Bullets & Headings
let kAppName = "TODAYX"
let kTodayCAP = "TODAY"
let kTomorrowCAP = "TOMORROW"
let kOverdueCAP = "OVERDUE"

// Colours and Fonts
let kCustomBackgroundColour = "customAero"
let kSubTextColour = "customBlue"
//let kSubTextColour = "customMPurple"
let kMainTextColour = "customBlue"
//let kMainTextColour = "customMStateBlue"
let kFranceBlueColour = "customBlueFrance"
let kJeansBlueColour = "customBlueJeans"
let kVeryLightBlueColour = "customBabyBlueEyes"

// Alert messages
let kUnknownAlert = "Unknown City"
let kUnknownMessageAlert = "No City Found, Try Again"
let kCityDefaultAlert = "Saved Default City"
let kCityDefaultMessageAlert = "This is now stored as your default location"

// Set m,in and max characters that we will allow,
let kMinCharsReminder = 1
let kMaxCharsReminder = 25
//let kCustomBackgroundColourRGB: UIColor {
//
//
//}

enum ResponseError: Error {
    case notConnectedToInternet
    case weatherRequestFailed
    case aqiRequestFailed
    case weatherLocationFailed
    case failedToDecodeRequest
}
