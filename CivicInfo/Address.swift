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

    let street: String
    let city: String
    let state: String
    
    enum SerializationError: Error {
        case missing(String)
    }
    
    init(placemark: CLPlacemark) throws {
        
        guard let street = placemark.name  else {
            throw SerializationError.missing("Missing street")
        }
        guard let city = placemark.locality else {
            throw SerializationError.missing("Missing city")
        }
        guard let state = placemark.administrativeArea else {
            throw SerializationError.missing("Missing state")
        }
        
        self.street = street
        self.city = city
        self.state = state
    }
    
    func url() -> URL? {
        
        var url: URL!
        
        //create URL from string components
        let base:String = "https://www.googleapis.com/civicinfo/v2/representatives?"

        let key: String = "key=AIzaSyBsfiJNet4tVvu1IFPG4qwSRuEw7e1b6h8"
        
        let rawString: String = base + key + "&address=" + street + city + state

        let encodedString: String = rawString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        print("\nencodedString: \(encodedString)")
        
        url = URL(string: encodedString as String)
        
        print("\nurl: \(url)")
        
        return url
    }
}
