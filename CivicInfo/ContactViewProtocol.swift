//
//  ContactViewProtocol.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/25/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

protocol ContactViewProtocol {
    func call(number: String)
    func email(address: String)
}
