//
//  Address.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/18/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation
import CoreLocation

struct Address {
    var zipCode: String {
        didSet {
            print("zipCode : \(zipCode)")
        }
    }
    
    enum AddressError: Error {
        case invalid(String)
    }
    
    init(placemark: CLPlacemark) throws {
        guard let postalCode = placemark.postalCode else {
            throw AddressError.invalid("invalid zipCode")
        }
        
        self.zipCode = postalCode
    }
    
    init(zipCode: String) {
        self.zipCode = zipCode
    }
    
    func url() -> URL? {
        
        var url: URL!
        
        //create URL from string components
        let base:String = "https://www.googleapis.com/civicinfo/v2/representatives?"
        
        let key: String = "key=AIzaSyBsfiJNet4tVvu1IFPG4qwSRuEw7e1b6h8"
        
        let rawString: String = base + key + "&address=" + self.zipCode
        
        let encodedString: String = rawString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        url = URL(string: encodedString as String)
        
        print("\nurl: \(url)")
        
        return url
    }
}

