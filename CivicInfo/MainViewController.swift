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
     public var presenter = MainPresenter()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self as UITableViewDataSource
        
        //Todo: Move to super class
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir-Black", size: 20)!]

        
        presenter.attachView(view: self)
        
        presenter.updateLocation()
    }
    
    override func didReceiveMemoryWarning() {
        presenter.flushCache()
    }
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue) {
        //presenter.zipCode has been set
    }

}

// MARK: - Table view data source
extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.representatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseId = "Cell"
        
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseId)! as! MainTableViewCell

        if (presenter.representatives.count != 0) {
            
            let index: Int = indexPath.row
            cell.representative = presenter.representatives[index]
            
            if presenter.representatives[index].imageURL != nil {
                
                let url = presenter.representatives[index].imageURL!
                
                //Create a key for caching downloaded image
                let key: NSString = NSString(string: url.path)
                
                print(key)
                
                //Check Cache for image
                if (presenter.imageCache.object(forKey: key) != nil) {
                    cell.photoView?.image = presenter.imageCache.object(forKey: key)
                } else {
                    
                    //cell.showStatusIndicator
                    
                    URLSession.shared.dataTask(with: url, completionHandler: {(data, repsonse, error) ->
                        Void in
                        
                        if (error != nil) {
                            print(error!)
                            return
                        }
                        
                        if let image = UIImage(data: data!) {
                            
                            self.presenter.imageCache.setObject(image, forKey: key)
                            
                            DispatchQueue.main.async { () -> Void in
                                
                                cell.photoView?.image = image
                                
                                cell.hideStatusIndicator()
                            }
                        }
                    }).resume()
                }
            } else {
                cell.photoView.image = UIImage(named: "icon")
                cell.hideStatusIndicator()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "contactSegue" {
            let destination = segue.destination as? ContactViewController,
            indexPath = tableView.indexPathForSelectedRow
            
            var representative = presenter.representatives[(indexPath?.row)!]
            
            let selectedCell: MainTableViewCell = tableView.cellForRow(at: indexPath!) as! MainTableViewCell
            
            if let image: UIImage = selectedCell.photoView.image {
                representative.image = image
            }
            
            destination?.representative = representative
        }
    }
}

extension MainViewController: MainViewProtocol
{
    func update(representatives: [Representative]) {
        presenter.representatives = representatives
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
