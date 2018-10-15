//
//  CityWeatherData.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit

class CityWeatherCell: UICollectionViewCell {
    //MARK:- Outlets
    @IBOutlet weak var labelHumidityValue: UILabel!
    @IBOutlet weak var labelDayInfo: UILabel!
    @IBOutlet weak var labelWindValue: UILabel!
    //MARK:- Variables
    var city: City! {
        didSet {
            labelHumidityValue.text = "\((city.weather?.main?.humidity)!)%"
            labelWindValue.text = "w \((city.weather?.wind?.speed)!) mps"
            labelDayInfo.text = (city.weather?.weather?[0].main)!
        }
    }
}
