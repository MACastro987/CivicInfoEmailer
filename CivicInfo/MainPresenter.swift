//
//  MainPresenter.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation
import CoreLocation

class MainPresenter
{
    public var placemark: CLPlacemark? {
        didSet {
            print(placemark!)
            address = Address(placemark: placemark!)
        }
    }
    
    private var mainView: RepresentativeView?
    private let locationService = LocationService()
    private var address: Address? {
        didSet {
            print(address?.url ?? "\nNo value for address?.url")
            
            self.requestRepresentatives(for: address!)
        }
    }
    
    func attachView(view: RepresentativeView) {
        mainView = view
    }
    
    func detachView() {
        mainView = nil
    }
    
    func getAddress() {
        locationService.presenter = self
        locationService.enableLocationManager()
    }
    
    func requestRepresentatives(for address: Address) {
        
        print(address)
        
        ClientService.requestRepresentatives(for: address, completion: {
            
            (representatives : [Representative]?) in
            
            if (representatives != nil) {
                self.mainView?.update(representatives: representatives!)
            }
        })
    }
}

