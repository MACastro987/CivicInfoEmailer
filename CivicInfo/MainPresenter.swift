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
    private var mainView : RepresentativeView?
    
    func attachView(view: RepresentativeView) {
        mainView = view
    }
    
    func detachView() {
        mainView = nil
    }
    
    func getInitialRepresentatives()
    {
        ClientService.requestRepresentatives(completion: {
            
            (representatives : [Representative]?) in
            
            if (representatives != nil) {
                self.mainView?.update(representatives: representatives!)
            }
        })
    }
}
