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
        }
    }

    public func hideStatusIndicator() {
        statusIndicator.stopAnimating()
        statusIndicator.isHidden =  true
    }
    
    override func layoutSubviews() {
        statusIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        statusIndicator.startAnimating()
        
        photoView.representativeCustomView()
    }
}






