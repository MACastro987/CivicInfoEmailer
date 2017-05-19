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
    var url: URL? {
        didSet {
            if (url != nil) {
                print("Yea!")
                //tell presenter to request representatives
            }
        }
    }
    
    enum SerializationError: Error {
        case missing(String)
    }
    
    init(placemark: CLPlacemark) {
        
        if let state = placemark.administrativeArea,
            let locality = placemark.locality,
            let name = placemark.name {
            
            //create URL from string components
            let base:String = "https://www.googleapis.com/civicinfo/v2/representatives?:"
            let key:String = "key=AIzaSyCgSLnS6o8BMt_UKccjOqx4zuyKGMX1XRA"
            let apnd = "%20"
            let stringBuilder: String = base + key + "&address=" + name + apnd + locality + apnd + state
            
            
            let formattedString: String = stringBuilder.replacingOccurrences(of: " ",
                                                                             with: "%20",
                                                                             options: .regularExpression)
            
            print("\nformattedString: \(formattedString)")
            
            setURL(newValue: formattedString)
        }
    }
    
    mutating func setURL(newValue: String) {
        self.url = URL(string: newValue)
    }
}
