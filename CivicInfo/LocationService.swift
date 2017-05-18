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
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.disableLocationManager()
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> () in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if let placemark = placemarks?.first {
                //Pass the placemark back to the presenter
                self.presenter?.address = placemark
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error : \(error)")
    }
}
