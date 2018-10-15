//
//	RootClass.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//	Copyright © 2018. All rights reserved.

import Foundation

struct DataContainer : BaseModel {

    struct Response: BaseModel, Equatable {
        var base : String?
        var clouds : Cloud?
        var cod : Int?
        var coord : Coord?
        var dt : Int?
        var id : Int?
        var main : Main?
        var name : String?
        var sys : Sy?
        var visibility : Int?
        var weather : [Weather]?
        var wind : Wind?
        var dt_txt: String?
        
        static func ==(lhs: Response, rhs: Response) -> Bool {
            return lhs.dt_txt == rhs.dt_txt
        }
    }

    struct request: BaseModel {
        var lat:Double?
        var long:Double?
    }
}
