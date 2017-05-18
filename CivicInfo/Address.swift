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
    var url: URL?
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(placemark: CLPlacemark) throws {
        
        //extract address string components from placemark
        guard let state = placemark.administrativeArea else { throw SerializationError.missing("No value for state")
        }
        
        guard let locality = placemark.locality else { throw SerializationError.missing("No value for state")
        }
        
        guard let name = placemark.name else { throw SerializationError.missing("No value for name")
        }
        
        //create URL from string components
        let apnd = "%20"
        let rawString = name + apnd + locality + apnd + state
        
        
        let formattedString = rawString.replacingOccurrences(of: " ",
                                                             with: "%20",
                                                             options: .regularExpression)
        
        print(formattedString)
        
        url = URL(string: formattedString)
    }
}
