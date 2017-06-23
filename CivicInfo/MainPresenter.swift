//
//  MainPresenter.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit
import CoreLocation

class MainPresenter {
    
    // Set to 'true' to use test JSON
    // Set to 'false' to query CivicInfo 
    private var inTestMode: Bool = true
    
    private var mainView: MainViewProtocol?
    var imageCache = NSCache<NSString, UIImage>()
    
    //This var contains all representatives
    var representatives: Array = [Representative]() {
        
        //Reload TableView when this var is set
        didSet { mainView?.reload() }
    }
    
    //MARK: Location
    
    private var locationService: LocationService?
    
    //This var is set when locationManager updates location
    public var placemark: CLPlacemark? {
        didSet {
            print(placemark!)
            do {
                address = try Address(placemark: placemark!)
            } catch {
                print("Unable to set MainPresenter.address with placemark")
            }
        }
    }
    
    public var zipCode: String? {
        didSet {
            self.address = Address(zipCode: zipCode!)
        }
    }
    
    //address initialized by placemark observer
    public var address: Address? {
        didSet {
            
            //Setting this var initiates the client request for representatives
            
            if self.inTestMode {
                //TEST
                ClientService.testRequest(completion: {
                    
                    (representatives: [Representative]?) in
                    
                    if (representatives != nil) {
                        self.mainView?.update(representatives: representatives!)
                    }
                })
            }
            
            else {
                //PRODUCTION
                ClientService.requestRepresentatives(for: address!, completion: {
                    
                    (representatives : [Representative]?) in
                    
                    if (representatives != nil) {
                        self.mainView?.update(representatives: representatives!)
                    }
                })
            }
        }
    }
    
    func attachView(view: MainViewProtocol) {
        mainView = view
    }
    
    func detachView() {
        mainView = nil
    }
    
    func updateLocation() {
        locationService = LocationService(presenter: self)
        locationService?.updateLocation()
    }
}

//This extension manages images
extension MainPresenter {
    func flushCache() {
        self.imageCache.removeAllObjects()
    }
}




















