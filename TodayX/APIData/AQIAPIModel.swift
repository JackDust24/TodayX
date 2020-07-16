//
//  AQIAPIModel.swift
//  TodayX
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: AQI Index
struct AQIIndexResponse: Decodable {
    let status: String?
    let data: DataAQI?

}

//MARK: Info about the City
struct DataAQI: Decodable {
    let aqi: Int?
    var idx: Int?
    let city: City?
    let iaqi: IAQI?
}

struct City: Decodable {
    var name: String?
}

//MARK: Other AQI info if I choose to use it.
struct IAQI: Decodable {
    let pm10: ValueInt?
    var so2: ValueInt?
    var no2: Value?
    var co: Value?
    var o3: Value?
}

struct ValueInt: Decodable {
    let v: Double?
}

struct Value: Decodable {
    let v: Double?
}

