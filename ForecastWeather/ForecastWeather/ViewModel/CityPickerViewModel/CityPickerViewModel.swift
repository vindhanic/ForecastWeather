//
//  CityPickerViewModel.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

struct CityPickerViewModel {
    //Webcall for getting city's weather data
    func createCity(coordinate:CLLocation, name:String, complition:@escaping (_ selectedCity:City)->()) {
        let param = DataContainer.request(lat: coordinate.coordinate.latitude, long: coordinate.coordinate.longitude)
        
        getWeatherList(param: param, success: { (result) in
            let updatedCity = City(name: name, latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude, weather: result)
            complition(updatedCity)
        }) { (error) in
            print(error)
        }
    }
}

