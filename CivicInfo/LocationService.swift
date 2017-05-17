//
//  LocationService.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/17/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation
import CoreLocation

class LocationProxy: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    public var presenter: MainPresenter?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func enableLocationManager() {
        locationManager.startUpdatingLocation()
    }
    
    func disableLocationManager() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.disableLocationManager()
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> () in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if placemarks?.count != 0 {
                let userLocation = placemarks?.first!
                
                let state = userLocation?.administrativeArea
                
                print(state ?? "No value for STATE")
                
                let city = userLocation?.locality
                
                print(city ?? "No value or CITY")
                
                let streetAddress = userLocation?.thoroughfare
                
                print(streetAddress ?? "No value for STREETADRESS")
                
                let streetNumber = userLocation?.subLocality
                
                print(streetNumber ?? "No value for STREETNUMBER")
                
                
                
                //Pass address to presenter
                //self.passAddress(placemark: pm!)
                
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func passAddress(placemark: CLPlacemark) {
        presenter?.address = placemark
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error : \(error)")
    }
}
