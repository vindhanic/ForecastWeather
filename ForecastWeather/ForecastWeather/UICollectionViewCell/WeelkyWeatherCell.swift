//
//  WeelkyWeatherCell.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class WeelkyWeatherCell: UICollectionViewCell {
    //Outlets
    @IBOutlet weak var labelWeekDay: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var labelMaxTemperature: UILabel!
    @IBOutlet weak var labelMinTemperature: UILabel!
    //MARK:- Variables
    var weatherData: DataContainer.Response! {
        didSet {
            labelWeekDay.text = "\(Int((weatherData?.dt)!))"
            if let maxTemp = weatherData?.main?.tempMax {
                labelMaxTemperature.text = "\(Int(maxTemp))° c"
            }
            else {
                labelMaxTemperature.text = "NA"
            }
            if let minTemp = weatherData?.main?.tempMin {
                labelMinTemperature.text = "\(Int(minTemp))° c"
            }
            else {
                labelMinTemperature.text = "NA"
            }
            let image = getImageFullURL(icon: (self.weatherData.weather?[0].icon)!)
            self.imageWeather.af_setImage(withURL: URL(string : image)!, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false, completion: { (image) in
            })
            labelWeekDay.text = getDayFromUnix(unix: (weatherData?.dt)!)
        }
    }
}
