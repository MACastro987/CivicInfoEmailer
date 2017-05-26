//
//  ContactViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/25/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {
    
    fileprivate var presenter = ContactPresenter()
    public var representative: Representative?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
        }
        if let email = representative?.email?.first {
            emailLabel.text = email
        }
    }
    
    @IBAction func call(_ sender: Any) {
        if phoneNumberLabel.text != nil {
            self.call(number: phoneNumberLabel.text!)
        }
    }
    
    @IBAction func email(_ sender: Any) {
        if emailLabel.text != nil {
            self.email(address: emailLabel.text!)    
        }
    }
}

extension ContactViewController: ContactViewProtocol {
    
    func call(number: String) {
        presenter.call(number: number)
    }
    
    func email(address: String) {
        presenter.email(address: address)
    }
}
