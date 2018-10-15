//
//  CityWeatherViewModel.swift
//  ForecastWeather
//
//  Created by Chirag on 14/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

struct CityWeatherViewModel {
    //Webcall for getting forecast weather data
    func getFiveDayWeather(coordinate:CLLocation, complition:@escaping (_ list:CityWeather)->()) {
        let param = DataContainer.request(lat: coordinate.coordinate.latitude, long: coordinate.coordinate.longitude)
        getFiveDayList(param: param, success: { (cityWeather) in
            complition(cityWeather)
        }) { (error) in
            print(error)
        }
    }
}
