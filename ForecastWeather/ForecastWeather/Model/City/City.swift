//
//  City.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

struct City: BaseModel, Equatable {
    var name: String?
    var latitude:Double?
    var longitude:Double?
    var weather:DataContainer.Response?
    
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}

struct CityContainer: BaseModel {
    var citys = [City]()
}

