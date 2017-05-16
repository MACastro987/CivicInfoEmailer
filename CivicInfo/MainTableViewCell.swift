//
//  MainTableViewCell.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/10/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    public var representative : Representative?
    {
        didSet
        {
            if (representative?.imageURL != nil)
            {
                if let url = representative?.imageURL!
                {
                    let key: NSString = NSString(string: url.path)
                    
                    //Check for image in cache
                    
                    if (imageCache.object(forKey: key) != nil)
                    {
                        photoView.image = imageCache.object(forKey: key)
                        
                    } else {
                        
                        URLSession.shared.dataTask(with: url, completionHandler: {(data, repsonse, error) ->
                            Void in
                            
                            if (error != nil) {
                                print(error!)
                                return
                            }
                            
                            if let image = UIImage(data: data!) {
                                
                                self.imageCache.setObject(image, forKey: key)
                                
                                DispatchQueue.main.async { () -> Void in
                                    
                                    self.photoView?.image = image
                                }
                            }
                        }).resume()

                    }
                    
                } else {
                    photoView.image = UIImage(named: "icon")
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}






