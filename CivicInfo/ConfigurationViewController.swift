//
//  ConfigurationViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/29/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    @IBOutlet weak var zipCodeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blurBackground()
        
        self.hideKeyboardOnTap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainScene = segue.destination as? MainViewController {
            if zipCodeField.text != nil {
                mainScene.presenter.zipCode = zipCodeField.text
            }
        }
    }
}

extension ConfigurationViewController {
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ConfigurationViewController {
    
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
