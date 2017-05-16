//
//  MainPresenter.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

class MainPresenter
{    
    private var representativeView : RepresentativeView?
    
    func attachView(view: RepresentativeView) {
        representativeView = view
    }
    
    func detachView() {
        representativeView = nil
    }
    
    func getInitialRepresentatives()
    {
        ClientService.requestRepresentatives(completion: {
            
            (representatives : [Representative]?) in
            
            if (representatives != nil) {
                self.representativeView?.update(representatives: representatives!)
            }
        })
    }
}
