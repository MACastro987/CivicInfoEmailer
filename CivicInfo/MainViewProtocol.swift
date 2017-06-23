//
//  RepresentativeView.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/10/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

protocol MainViewProtocol {
    func update(representatives: [Representative])
    func reload()
}
