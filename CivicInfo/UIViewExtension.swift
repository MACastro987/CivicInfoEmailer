//
//  UIViewExtension.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/24/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func representativeCustomView() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        
        self.setRounded()
    }
}
