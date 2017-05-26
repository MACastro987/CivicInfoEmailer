//
//  ContactPresenter.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/25/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

class ContactPresenter {
    
    private var contactView: ContactViewProtocol?
    
    func attachView(view: ContactViewController) {
        contactView = view
    }
    
    func detachView() {
        contactView = nil
    }
    
    func call(number: String) {
        print("calling number: \(number)")
    }
    
    func email(address: String) {
        print("emailing address: \(address)")
    }
}
