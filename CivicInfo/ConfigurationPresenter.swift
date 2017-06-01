//
//  ConfigurationPresenter.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/31/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

protocol ConfigurationProtocol {
    func setAddress()
    func blurBackground()
}

class ConfigurationPresenter {
    
    private var configurationView: ConfigurationProtocol?
    
    func attachView(view: ConfigurationViewController) {
        configurationView = view
    }
    
    func detachView() {
        configurationView = nil
    }
}
