//
//  Deserializer.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/10/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation
import UIKit

public struct Deserializer {
    
    var JSON: [String: Any]
    
    var Representatives: [Representative]?
    
    
    init(json: [String : Any]) {
        JSON = json
    }
    
    enum DeserializationError: Error {
        case invalid(String)
        case missing(String)
        case assignment(String)
    }
    
    func getRepresentatives() throws -> [Representative]
    {
        var repArray = [Representative]()
        
        guard let officials = JSON["officials"] as? [[String: Any]] else { throw DeserializationError.missing("Key 'officials' not found") }
        
        print(officials)
        
        for official in officials
        {
            var representative = Representative()

            if let imageString  = official["photoUrl"] as? String {
                representative.imageURL = URL(string: imageString)
            }
            
            repArray.append(representative)
        }
        
        return repArray
    }
}






