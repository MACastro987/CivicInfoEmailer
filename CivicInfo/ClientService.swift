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
        case invalid(String)
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
            
            representatives = try self.deserialize(json: json)
            
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
                        
                        representatives = try self.deserialize(json: json)
                        
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
    
    static func deserialize(json: [String: AnyObject]) throws -> [Representative]
    {
        var repArray = [Representative]()
        
        if let officials = json["officials"] as? [[String: Any]] {
        
            for official in officials
            {
                var representative = Representative()
                
                if let name = official["name"] as? String {
                    representative.name = name
                }
                
                if let party = official["party"] as? String {
                    representative.party = party
                }
                
                if let imageUrlString = official["photoUrl"] as? String {
                    if let imageUrl = URL(string: imageUrlString) {
                        representative.imageURL = imageUrl
                    }
                }
                
                if let phone = official["phones"] as? [String] {
                    representative.phone = phone
                }
                
                if let email = official["email"] as? [String] {
                    representative.email = email
                }
                
                repArray.append(representative)
            }
        }
        
        return repArray
    }
}






