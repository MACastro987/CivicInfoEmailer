//
//  ClientService.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import Foundation

class ClientService {
    
    static func requestRepresentatives()
    {
        URLSession.shared.dataTask(with: GoogleApi.requestUrl, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    print(json)
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
}
