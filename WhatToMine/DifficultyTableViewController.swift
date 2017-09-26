//
//  DifficultyTableViewController.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 9/18/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import SVProgressHUD
import StoreKit


class DifficultyTableViewController: UITableViewController, SKStoreProductViewControllerDelegate {

    var data:[DifficultyForRevenue] = [.current, .c24h, .c3d, .c7d]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        
        cell.textLabel?.text = self.data[indexPath.row].description
        if self.data[indexPath.row].rawValue == LocalDataManager.selectedDifficulty {
            cell.detailTextLabel?.text = "Selected"
        } else {
            cell.detailTextLabel?.text = ""
            
            #if PRO
                
            #else
                if indexPath.row >= 1 {
                    cell.detailTextLabel?.text = "Pro version"
                }
            #endif
        }
        
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        #if PRO
        SVProgressHUD.show()
        LocalDataManager.selectedDifficulty = self.data[indexPath.row].rawValue
            LocalDataManager.loadAllData(completion: { (success) in
                guard success == true else {
                    SVProgressHUD.showError(withStatus: "Connectibity problems. Refresh in 30 seconds")
                    return
                }
                SVProgressHUD.showSuccess(withStatus: "Successfully changed")
                self.navigationController?.popViewController(animated: true)
            })
        #else
            let alertController = UIAlertController(title: "Message", message: "You need the full version in order to change to the selected currencies", preferredStyle: .alert)
            let buyAction = UIAlertAction(title: "Get", style: .default, handler: { (action) in
                SVProgressHUD.show()
                let storeProductViewController = SKStoreProductViewController()
                storeProductViewController.delegate = self
                
                let parametersDict = [SKStoreProductParameterITunesItemIdentifier: 1271882476]
                
                storeProductViewController.loadProduct(withParameters: parametersDict, completionBlock: { (status: Bool, error: Error?) -> Void in
                    SVProgressHUD.dismiss()
                    if status {
                        self.present(storeProductViewController, animated: true, completion: nil)
                    }
                    else {
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }}})
                
            })
            let cancelAction = UIAlertAction(title: "I will miss", style: .destructive, handler: { (action) in
                alertController.dismiss(animated: true, completion: {
                    
                })
            })
            alertController.addAction(buyAction)
            alertController.addAction(cancelAction)
            self.navigationController?.present(alertController, animated: true, completion: {
                
            })
        #endif
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
