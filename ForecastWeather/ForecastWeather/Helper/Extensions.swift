//
//  Extensions.swift
//  ForecastWeather
//
//  Created by Chirag on 14/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    //Array extension for removing duplicate data
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}


