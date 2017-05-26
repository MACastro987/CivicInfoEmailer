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
    fileprivate var presenter = MainPresenter()

    @IBOutlet weak var tableView: UITableView!
    
    var representatives = [Representative]() {
        didSet { self.reload() }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir-Black", size: 20)!]

        
        presenter.attachView(view: self)
        
        presenter.updateLocation()
        
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
        return representatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseId = "Cell"
        
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId)! as! MainTableViewCell

        if (representatives.count != 0) {
            let index: Int = indexPath.row
            
            cell.representative = representatives[index]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactIdentifier = "contactSegue"
        if segue.identifier == contactIdentifier {
            let destination = segue.destination as? ContactViewController,
            index = tableView.indexPathForSelectedRow?.row
            
            destination?.representative = self.representatives[index!]
        }
    }
}

extension MainViewController: MainViewProtocol
{
    func update(representatives: [Representative]) {
        self.representatives = representatives
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
