//
//  BookmarkViewModel.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation

class BookmarkViewModel {
    var citys = [City]()
    //Getting city list from local disk
     func prepareCityList() {
        guard let container = getObject(objectType: CityContainer.self, key: kCity) else {
            return
        }
        citys = container.citys
    }
    //Save city data to local disk
     func bookMarkCity(city: City, complition: voidCloser) {
        citys.append(city)
        citys = citys.removingDuplicates()
        let container = CityContainer(citys: citys)
        _ = saveObject(storageObject: container, key: kCity)
        complition()
    }
    //Remove city data from local disk
     func removeobject(index:Int, complition: voidCloser)  {
        citys.remove(at: index)
        let container = CityContainer(citys: citys)
        _ = saveObject(storageObject: container, key: kCity)
        complition()
    }
    //Get updated weather data for each city
     func updateLiveValue(complition: @escaping voidCloser)  {
        CityReqeust().updateCity(citys: citys) { (updatedCitys) in
            self.citys = updatedCitys
            let container = CityContainer(citys: self.citys)
            _ = saveObject(storageObject: container, key: kCity)
            complition()
        }
    }
}
