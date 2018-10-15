//
//  ForecastWeatherTests.swift
//  ForecastWeatherTests
//
//  Created by Chirag on 11/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import XCTest

let kTestLocation = CLLocation(latitude: 23.0225, longitude: 72.5714)
let kTestCity = "Ahmedabad"
let kCityPickerViewIdentifier = "CityPickerViewController"
let kCityWeatherViewIdentifier = "CityWeatherViewController"

@testable import ForecastWeather
class ForecastWeatherTests: XCTestCase {
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let expectation = XCTestExpectation(description: "Expectation to perform asyncronous operation")

    override func setUp() {
        super.setUp()
        
        XCTAssertNotNil(storyboard, "There is issue in storyboard initialisation")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateCity() {
        let cityPickerVC = storyboard.instantiateViewController(withIdentifier: kCityPickerViewIdentifier) as! CityPickerViewController
        XCTAssertNotNil(cityPickerVC, "ViewController should not be nil")
        
        cityPickerVC.viewModel.createCity(coordinate: kTestLocation, name: kTestCity) { (city) in
            XCTAssertNotNil(city, "unable to fetch city")
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetFiveDayWeather() {
        let cityWeatherVC = storyboard.instantiateViewController(withIdentifier: kCityWeatherViewIdentifier) as! CityWeatherViewController
        XCTAssertNotNil(cityWeatherVC, "ViewController should not be nil")
        
        cityWeatherVC.viewModel.getFiveDayWeather(coordinate: kTestLocation) { (cityWeather) in
            
            XCTAssertNotNil(cityWeather, "unable to fetch city")
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
