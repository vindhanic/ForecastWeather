//
//  CityWeatherViewController.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var collectionViewWeather: UICollectionView!
    //MARK:- Variables
    var city: City?
    var viewModel = CityWeatherViewModel()
    var cityWeather: CityWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: true)
        prepareView()
        getNextFiveDayWeather()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewWeather.collectionViewLayout.invalidateLayout()
    }
    //MARK:- Helper Methods
    func prepareView() {
        collectionViewWeather.register(UINib(nibName: XIBClassName.CityHeaderCell, bundle: nil) , forCellWithReuseIdentifier: CellIdentifier.kCityHeaderCellID)
        collectionViewWeather.register(UINib(nibName: XIBClassName.CityWeatherCell, bundle: nil) , forCellWithReuseIdentifier: CellIdentifier.kCityWeatherCellID)
        collectionViewWeather.register(UINib(nibName: XIBClassName.WeelkyWeatherCell, bundle: nil) , forCellWithReuseIdentifier: CellIdentifier.kWeeklyWeatherCellID)
        collectionViewWeather.reloadData()
    }
    //Get forecast weather data
    func getNextFiveDayWeather() {
        let location = CLLocation(latitude: CLLocationDegrees((city?.weather?.coord?.lat)!), longitude: CLLocationDegrees((city?.weather?.coord?.lon)!))
        viewModel.getFiveDayWeather(coordinate: location) { [weak self] (cityWeather) in
            print(cityWeather)
            self?.cityWeather = cityWeather
            var array = cityWeather.list
            array = array.map({ (data) -> DataContainer.Response in
                var new = data
                new.dt_txt = data.dt_txt?.components(separatedBy: " ").first!                
                return new
            })
            var updatedArray = self?.cityWeather?.list
            print(array)
            updatedArray = array.removingDuplicates()
            self?.cityWeather?.list = updatedArray!
            self?.cityWeather?.list.removeFirst()
            self?.collectionViewWeather.reloadData()
        }
    }
}
//MARK:- UICollectionView
extension CityWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = cityWeather?.list.count {
            return 2 + count
        }
        else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cellHeader = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.kCityHeaderCellID, for: indexPath) as! CityHeaderCell
            cellHeader.city = city
            return cellHeader
        }
        else if indexPath.row == 1 {
            let cellWeather = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.kCityWeatherCellID, for: indexPath) as! CityWeatherCell
            cellWeather.city = city
            return cellWeather
        }
        else {
            let cellWeekly = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.kWeeklyWeatherCellID, for: indexPath) as! WeelkyWeatherCell
            cellWeekly.weatherData = cityWeather?.list[indexPath.row - 2]
            return cellWeekly
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height: 150)
        }
        else if indexPath.row == 1 {
            return CGSize(width: view.frame.width, height: 80)
        }
        else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
}
