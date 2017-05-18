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
    public var address: CLPlacemark? {
        didSet {
            createRequest(placemark: address!)
        }
    }
    
    private let locationProxy = LocationProxy()
    
    private var mainView: RepresentativeView?
    
    func attachView(view: RepresentativeView) {
        mainView = view
    }
    
    func detachView() {
        mainView = nil
    }
    
    func getAddress() {
        locationProxy.presenter = self
        locationProxy.enableLocationManager()
    }
    
    func createRequest(placemark: CLPlacemark) {
        do {
            requestRepresentatives(for: try Address(placemark: placemark))
            
        } catch {
            print("Unable to initialize address")
        }
    }
    
    func requestRepresentatives(for address: Address) {
        
        ClientService.requestRepresentatives(completion: {
            
            (representatives : [Representative]?) in
            
            if (representatives != nil) {
                self.mainView?.update(representatives: representatives!)
            }
        })
    }
}

