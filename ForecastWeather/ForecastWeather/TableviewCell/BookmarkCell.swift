//
//  BookmarkCell.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit

class BookmarkCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    //MARK:- Variables
    var city: City! {
        didSet {
            labelCityName.text = city.name!
            labelTemperature.text = "\(Int((city.weather?.main?.temp)!))° c"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
