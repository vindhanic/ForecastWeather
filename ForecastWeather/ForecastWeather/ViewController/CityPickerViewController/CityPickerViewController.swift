//
//  CityPickerViewController.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import UIKit
import MapKit
protocol CityPickerDelegate {
    func didSelectCity(selectedCity: City) -> Void
}
class CityPickerViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    //MARK:- Variable
    var locationManager = CLLocationManager()
    var cityCoordinate : CLLocationCoordinate2D?
    var selectedCity: City? {
        didSet {
            lblCityName.text = selectedCity?.name!
        }
    }
    var delegate: CityPickerDelegate?
    let viewModel = CityPickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMap()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- IBAction
    @IBAction func btnDoneClick(_ sender: Any) {
        guard let city = selectedCity else {
            return
        }
        delegate?.didSelectCity(selectedCity: city)
        navigationController?.popViewController(animated: true)
    }
    
    //fetch city name from location coordinate
    func fetchCity(from location: CLLocation, completion: @escaping (_ city: String?,  _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       error)
        }
    }
    //MARK:- Helper Method
    //Show current location
    func prepareMap()  {
        //Location Manager code to fetch current location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    //Adding marker to map for tapped location
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        fetchCity(from: location) { (city, error) in
            if error == nil, city != nil {
                
                self.viewMap.clear()
                let marker = GMSMarker(position: coordinate)
                marker.isDraggable = true
                self.cityCoordinate = coordinate
                marker.map = self.viewMap
                
                
                self.viewModel.createCity(coordinate: location, name: city!, complition: { (result) in
                    self.selectedCity = result
                })
            }
            
        }
    }
}

//MARK:- Location Delegate
extension CityPickerViewController : CLLocationManagerDelegate {
    //Updating location and adding marker to current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:  (location?.coordinate.longitude)!, zoom: 17.0)
        viewMap.animate(to: camera)
        
        self.locationManager.stopUpdatingLocation()
        let coordinate = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        addMarker(coordinate: coordinate)
    }
}

//MARK:- Google Map delegate
extension CityPickerViewController : GMSMapViewDelegate {
    //Adding marker on tap
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        addMarker(coordinate: coordinate)
    }
    //Getting city when user drag and drop marker
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        cityCoordinate = marker.position
        let location = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        fetchCity(from: location) { (city, error) in
            if error == nil {
                self.viewModel.createCity(coordinate: location, name: city!, complition: { (result) in
                    self.selectedCity = result
                })
            }
        }
    }
}
