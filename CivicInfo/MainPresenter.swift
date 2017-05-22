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
    //TESTING?
    private var inTestMode: Bool = true
    
    private var mainView: RepresentativeView?
    private var locationService: LocationService?
    
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
    
    private var address: Address? {
        didSet {
            
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
    
    func attachView(view: RepresentativeView) {
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




















