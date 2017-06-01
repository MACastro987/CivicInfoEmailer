//
//  ConfigurationViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/29/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    fileprivate var presenter = ConfigurationPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(view: self)
        
        self.blurBackground()
    }
}

extension ConfigurationViewController: ConfigurationProtocol {
    
    func setAddress() {
        
    }
    
    func blurBackground() {
        // MARK: - Blur & Vibrancy
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.insertSubview(blurEffectView, at: 0)
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        
        //Add the vibrancy view to the blur view
        blurEffectView.contentView.addSubview(vibrancyEffectView)
    }
}
