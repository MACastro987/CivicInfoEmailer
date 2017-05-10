//
//  MainViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

//todo: remove extensions after testing
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
//end: todo

class MainViewController: UIViewController
{
    fileprivate var mainPresenter = MainPresenter()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainPresenter.attachView(view: self)
        mainPresenter.getInitialRepresentatives()
        
        tableView.delegate = self
        tableView.dataSource = self as UITableViewDataSource
    }
}

// MARK: - Table view data source
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseId = "Cell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId)!

        cell.backgroundColor = .random()

        return cell
    }
}

extension MainViewController: RepresentativeView
{
    func showLoadingIndicator() {
        print("showLoadingIndicator()")
    }
    
    func hideLoadingIndicator() {
        print("hideLoadingIndicator()")
    }
}
