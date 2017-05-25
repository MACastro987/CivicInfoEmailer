//
//  MainViewController.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/8/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    fileprivate var mainPresenter = MainPresenter()

    @IBOutlet weak var tableView: UITableView!
    
    var Representatives = [Representative]() {
        didSet { self.reload() }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "AvenirNext-Bold", size: 20)!]

        
        mainPresenter.attachView(view: self)
        
        mainPresenter.updateLocation()
        
        tableView.delegate = self
        tableView.dataSource = self as UITableViewDataSource
    }
    
    override func didReceiveMemoryWarning() {
        //mainPresenter.flushCache()
    }
}

// MARK: - Table view data source
extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Representatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseId = "Cell"
        
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId)! as! MainTableViewCell

        if (Representatives.count != 0) {
            let index: Int = indexPath.row
            
            cell.representative = Representatives[index]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: RepresentativeView
{
    func update(representatives: [Representative]) {
        Representatives = representatives
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoadingIndicator() {
        print("showLoadingIndicator()")
    }
    
    func hideLoadingIndicator() {
        print("hideLoadingIndicator()")
    }
}
