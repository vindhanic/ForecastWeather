//
//  Storage.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation
//Save object based on key from local disk
func saveObject<T: Codable>(storageObject:T, key: String) -> Bool {
    do {
        let data = try JSONEncoder().encode(storageObject)
        UserDefaults.standard.set(data, forKey: key)
        return true
    } catch  {
        return false
    }
}
//Get object based on key from local disk
func getObject<T: Codable>(objectType:T.Type, key:String) -> T? {
    do {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {
            return nil
        }
        
        let object = try JSONDecoder().decode(objectType, from: data)
        return object
    } catch {
        return nil
    }
}

