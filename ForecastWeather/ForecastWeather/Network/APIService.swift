//
//  APIService.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation
//Get city weather date webcall
func getWeatherList(param: DataContainer.request, success:@escaping (_ result: DataContainer.Response)->(), failure:@escaping failerHandler) {
    
    let urlString = uWeatherList + "lat=\(String(describing: param.lat!))&lon=\(String(describing: param.long!))" + "&appid=" + kAPIToken + "&units=metric"
    guard let url = URL(string: urlString) else {
        return
    }
    
    Request.shared.callService(method: .GET, param: nil, path: url, responseModel: DataContainer.Response.self, success: success , failure: failure)
}

//Get City forecast data webcall
func getFiveDayList(param: DataContainer.request, success:@escaping (_ result: CityWeather)->(), failure:@escaping failerHandler) {
    
    let urlString = uForecast + "lat=\(String(describing: param.lat!))&lon=\(String(describing: param.long!))" + "&appid=" + kAPIToken + "&units=metric" //+ "&cnt=5"
    guard let url = URL(string: urlString) else {
        return
    }
    
   Request.shared.callService(method: .GET, param: nil, path: url, responseModel: CityWeather.self, success: success, failure: failure)
}


