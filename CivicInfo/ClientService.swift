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
    
    static func testRequest(completion: @escaping ([Representative]?) -> ()) {
        var representatives = [Representative]()
        
        guard let path = Bundle.main.path(forResource: "SampleJSON", ofType: "txt")
            else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
            print(json)
            representatives = self.deserialize(json: json)
            
        } catch {
            print(error)
        }
        
        completion(representatives)

    }
    
    static func requestRepresentatives(for address: Address, completion: @escaping ([Representative]?) -> ())
    {
        var representatives = [Representative]()
        
        if let url = address.url() {
            
            URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) in
                
                if(error != nil) {
                    print("error")
                }
                    
                else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                        
                        print(json)
                        
                        representatives = self.deserialize(json: json)
                        
                        print(representatives)
                        
                    } catch let error as NSError{
                        print(error)
                    }
                    
                    completion(representatives)
                }
            }).resume()
        }
        
        else {
            print("Address.url not available")
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






