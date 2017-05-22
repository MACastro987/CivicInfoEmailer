//
//  ContactViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/22/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    public var representative: Representative?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var emailBodyView: UITextView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
