//
//  Constants.swift
//  ForecastWeather
//
//  Created by Chirag on 11/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

let GoogleAPIKey = "AIzaSyCC1mTEeXC0CxQvWqMsQtz5rUe-r9eMDMg"

let ImageUrl = "http://openweathermap.org/img/w/"

struct Constants
{
    static let kAppName = "ForecastWeather"
}

//MARK:- XIB Class Name
struct XIBClassName {
    static let BookmarkCell = "BookmarkCell"
    static let CityHeaderCell = "CityHeaderCell"
    static let CityWeatherCell = "CityWeatherCell"
    static let WeelkyWeatherCell = "WeelkyWeatherCell"
}

//MARK:- Cell Identifier
struct CellIdentifier {
    static let kBookmarkCellID = "bookmarkCellID"
    static let kWeeklyWeatherCellID = "WeeklyWeatherCellID"
    static let kCityWeatherCellID = "CityWeatherCellID"
    static let kCityHeaderCellID = "CityHeaderCellID"
}

//MARK:- Segue
struct Segues {
    static let bookmarkListToDetail = "listToDetail"
    static let bookmarkListToCityPicker = "toCityPickerViewController"
}
