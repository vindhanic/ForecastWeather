//
//  CityHeaderCell.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit

class CityHeaderCell: UICollectionViewCell {
    //MARK:- Outlets
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelWeekday: UILabel!
    @IBOutlet weak var labelMaxTemperature: UILabel!
    @IBOutlet weak var labelMinTemperature: UILabel!
    //MARK:- Variables
    var city: City! {
        didSet {
            labelCityName.text = city.name!
            labelTemperature.text = "\(Int((city.weather?.main?.temp)!))° c"
            labelWeekday.text = getTodayDay()
            if let maxTemp = city.weather?.main?.tempMax {
                labelMaxTemperature.text = "\(Int(maxTemp))° c"
            }
            else {
                labelMaxTemperature.text = "NA"
            }
            if let minTemp = city.weather?.main?.tempMin {
                labelMinTemperature.text = "\(Int(minTemp))° c"
            }
            else {
                labelMinTemperature.text = "NA"
            }
        }
    }
}
