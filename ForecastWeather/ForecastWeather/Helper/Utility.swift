//
//  Utility.swift
//  ForecastWeather
//
//  Created by Chirag on 14/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation
//Get weather full image path
func getImageFullURL(icon: String) -> String {
    return "\(ImageUrl)\(icon).png"
}
//Get weekday name from unix timestamp from API
func getDayFromUnix(unix: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(unix))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEEE" //Specify your format that you want
    return dateFormatter.string(from: date)
}
//Get today's weekday name
func getTodayDay() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEEE" //Specify your format that you want
    return dateFormatter.string(from: date)
}
