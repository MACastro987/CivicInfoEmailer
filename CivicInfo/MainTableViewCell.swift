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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var statusIndicator: UIActivityIndicatorView!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    public var representative : Representative?
    {
        didSet
        {
            if (representative?.name != nil) {
                nameLabel.text = representative?.name
            }
            
            if (representative?.party != nil) {
                partyLabel.text = representative?.party
            }
            
            if (representative?.imageURL != nil)
            {
                if let url = representative?.imageURL!
                {
                    let key: NSString = NSString(string: url.path)
                    
                    //Check for image in cache
                    
                    if (imageCache.object(forKey: key) != nil)
                    {
                        photoView.image = imageCache.object(forKey: key)
                        
                        self.hideStatusIndicator()
                        
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
                                    
                                    self.hideStatusIndicator()
                                }
                            }
                        }).resume()

                    }
                    
                } else {
                    photoView.image = UIImage(named: "icon")
                    
                    self.hideStatusIndicator()
                }
            }
        }
    }
    
    private func loadImageAsync() {
        
    }
    private func hideStatusIndicator() {
        statusIndicator.stopAnimating()
        statusIndicator.isHidden =  true
    }
    
    override func layoutSubviews() {
        
        statusIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        statusIndicator.startAnimating()
        
        photoView.representativeCustomView()
    }
}






