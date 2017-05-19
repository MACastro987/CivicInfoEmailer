//
//  ClientService.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

struct ClientService {
    
    enum DeserializationError: Error {
        case missing(String)
    }
    
    static func requestRepresentatives(for address: Address, completion: @escaping ([Representative]?) -> ())
    {
        var representatives = [Representative]()
        
        print(address)
        
        if (address.url != nil) {
            
            URLSession.shared.dataTask(with: address.url!, completionHandler: {
                (data, response, error) in
                if(error != nil){
                    print("error")
                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                        
                        print(json)
                        
                        representatives = self.deserialize(json: json)
                        
                    } catch let error as NSError{
                        print(error)
                    }
                    
                    completion(representatives)
                }
            }).resume()
        }
    }
    
    static func deserialize(json: [String: AnyObject]) -> [Representative]
    {
        var repArray = [Representative]()
        
        if let officials = json["officials"] as? [[String: Any]] {
        
            for official in officials
            {
                if let imageString  = official["photoUrl"] as? String {
                    
                    let representative = Representative(imageURL: URL(string: imageString))
                    
                    repArray.append(representative)
                }
            }
        }
        
        return repArray
    }
}






