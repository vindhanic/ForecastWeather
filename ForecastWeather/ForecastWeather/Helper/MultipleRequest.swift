//
//  MultipleRequest.swift
//  ForecastWeather
//
//  Created by Chirag on 14/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

//
class CityReqeust  {
    var queue = OperationQueue()
    //Getting city vise updated data from bookmark view model 
    func updateCity(citys:[City], complition:@escaping (_ citys:[City])->()) {
        var updatedCity = [City]()
        var index = 0
        for city in citys {
            
            queue.addOperation {
                let param = DataContainer.request(lat: city.latitude, long: city.longitude)
                getWeatherList(param: param, success: { (result) in
                    let updated = City(name: city.name, latitude: city.latitude, longitude: city.longitude, weather: result)
                    updatedCity.append(updated)
                    if index == (citys.count - 1) {
                        complition(updatedCity)
                    }
                    index = index + 1
                }, failure: { (error) in
                    
                })
            }
            
            
        }
    }
}
