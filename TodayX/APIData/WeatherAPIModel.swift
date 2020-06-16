//
//  WeatherForecast.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
// This is loaded from the results of the API.

import Foundation

import SwiftUI

// The details from the JSON file
// MARK: - TopLevel

struct ForecastWeatherResponse: Decodable {
    let name: String?
    let main: Temperature?
    let weather: [Weather]?
    let sys: LocationDetails?
}

// MARK: - Main
struct Temperature: Decodable {
    let temp: Double?
}

// MARK: - LocationDetails
struct LocationDetails: Decodable {
    let country: String?
}

// MARK: - Weather
struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
