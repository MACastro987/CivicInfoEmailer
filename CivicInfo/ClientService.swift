//
//  ClientService.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

class ClientService
{
    static func requestRepresentatives(completion: @escaping ([Representative]?) -> ())
    {
        var representatives = [Representative]()
        
        URLSession.shared.dataTask(with: GoogleApi.requestUrl, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    do{
                        let deserializer = Deserializer(json: json)
                    
                        representatives = try deserializer.getRepresentatives()
                    }
                    
                }catch let error as NSError{
                    print(error)
                }
                
                completion(representatives)
            }
        }).resume()
    }
}






