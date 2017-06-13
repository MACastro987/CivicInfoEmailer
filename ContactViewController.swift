//
//  ContactViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/25/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UITableViewController {
    
    fileprivate var presenter = ContactPresenter()
    public var representative: Representative?

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if let name = representative?.name {
            nameLabel.text = name
        }
        
        if let phone = representative?.phone?.first {
            phoneNumberLabel.text = phone
        } else {
            //Disable phone when number not provided
            callButton.isHidden = true
            phoneNumberLabel.text = "Not Available"
        }
        
        if let email = representative?.email?.first {
            emailLabel.text = email
        } else {
            //Diable email when address not provided
            emailButton.isHidden = true
            emailLabel.text = "Not Available"
        }
        
        if let image: UIImage = representative?.image {
            photoView.image = image
        }
    }
    
    override func viewWillLayoutSubviews() {
        photoView.representativeCustomView()
    }
    
    @IBAction func call(_ sender: Any) {
        if phoneNumberLabel.text != nil {
            call(number: phoneNumberLabel.text!)
        }
    }
    
    @IBAction func email(_ sender: Any) {
        if emailLabel.text != nil {
            email(address: emailLabel.text!)    
        }
    }
}

extension ContactViewController: ContactViewProtocol {
    func call(number: String) {
        presenter.call(number: number)
    }
}

extension ContactViewController: MFMailComposeViewControllerDelegate {
    func email(address: String) {
        
        let composeViewController = MFMailComposeViewController()
        composeViewController.mailComposeDelegate = self
        
        composeViewController.setToRecipients([emailLabel.text!])
        composeViewController.setSubject("A message from your constituent")
        composeViewController.setMessageBody("Message...", isHTML: false)
        
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}


