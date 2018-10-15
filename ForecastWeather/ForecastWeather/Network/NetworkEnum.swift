//
//  NetworkEnum.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

enum MethodType:String {
    case GET
    case POST
    case PUT
    case PATCH
}

enum requestError:Error {
    case paramInvalid
    case serviceError
    case notValidResponse
}
