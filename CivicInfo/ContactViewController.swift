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
    
    @IBAction func sendEmail(_ sender: Any) {
        print("Sending email: \(String(describing: emailAddressField.text))")
    }
    @IBAction func call(_ sender: Any) {
        print("Calling number: \(String(describing: phoneNumberLabel.text))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailBodyView.delegate = self
        emailBodyView.text = "Enter you message here"
        emailBodyView.textColor = .lightGray

        if representative?.name != nil {
            nameLabel.text = representative?.name
        }
        
        if representative?.email != nil {
            emailAddressField.text = representative?.email?.first
        } else {
            emailAddressField.text = "Sorry, no email addres provided"
        }
        
        if representative?.phone != nil {
            phoneNumberLabel.text = representative?.phone?.first
        }
    }
}

extension ContactViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
}
