//
//  TodayXTests.swift
//  TodayXTests
//
//  Created by JasonMac on 16/6/2563 BE.
//  Copyright © 2563 Jason Whittaker. All rights reserved.
//

import XCTest
@testable import TodayX

class TodayXTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
    func testGetWeatherResponse() {
        // Given
        let city = "Bangkok"
        // When
        let service = WeatherService()

        let forecastExpectation = expectation(description: "forecast")
        var response: Any?
        
        service.getWeatherForecast(matching: city) { forecast in
            print("1")
            print(forecast as Any)
            response = forecast
            forecastExpectation.fulfill()
        }
        // Then
        waitForExpectations(timeout: 1) { _ in
            
            print(response as Any)
            XCTAssertNotNil(response)
        }
    }
    
    func testConvertIntToTag() {
        
        let result = AddReminderVM().convertIntsToTag(from: 4)
        XCTAssertEqual(result, "Normal", "Wrong Result")
    }
    
}
