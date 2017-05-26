//
//  ContactPresenter.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/25/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class ContactPresenter {
    
    private var contactView: ContactViewProtocol?
    
    func attachView(view: ContactViewController) {
        contactView = view
    }
    
    func detachView() {
        contactView = nil
    }
    
    func call(number: String) {
        let phone = number.replacingOccurrences(of: "[ |()-]", with: "", options: [.regularExpression])
        
        let url = URL(string: "telprompt://" + phone)!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func email(address: String) {
        print("emailing address: \(address)")
    }
}
