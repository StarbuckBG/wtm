//
//  CoinDetailsTableViewController.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/15/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import StoreKit
import SVProgressHUD


class CoinDetailsTableViewController: UITableViewController,  SKStoreProductViewControllerDelegate{

    
    var coin: CoinData = CoinData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = coin.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoinImageTableViewCell") as! CoinImageTableViewCell
            if let image = coin.imageName(), let imageURL = URL(string: image) {
                cell.coinImageView.sd_setImage(with: imageURL, completed: { (image, err, cacheType, url) in
                })
            }
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        
        switch indexPath.row {
        case 1:
            cell.textLabel?.text = "Currency"
            cell.detailTextLabel?.text = coin.name
            
        case 2:
            cell.textLabel?.text = "Algorithm"
            cell.detailTextLabel?.text = coin.algorithm
            
        case 3:
            cell.textLabel?.text = "Block time"
            cell.detailTextLabel?.text = coin.block_time + " s"
            
        case 4:
            cell.textLabel?.text = "Difficulty"
            cell.detailTextLabel?.text = "\(coin.difficulty)"
            
        case 5:
            cell.textLabel?.text = "Difficulty change"
            cell.detailTextLabel?.text = String(format: "%0.2f%%",((coin.difficulty/coin.difficulty24)-1.00)*100)
            
        case 6:
            cell.textLabel?.text = "Estimated rewards"
            cell.detailTextLabel?.text = coin.estimated_rewards
            
        case 7:
            cell.textLabel?.text = "Exchange rate"
            cell.detailTextLabel?.text = "\(coin.exchange_rate)"
            
        case 8:
            cell.textLabel?.text = "Exchange rate change"
            cell.detailTextLabel?.text = String(format: "%0.2f%%", ((coin.exchange_rate/coin.exchange_rate24)-1.00)*100)
            
        case 9:
            cell.textLabel?.text = "Revenue"
            cell.detailTextLabel?.text = "\(coin.btc_revenue) BTC"
            
        case 10:
            cell.textLabel?.text = "Profit"
            cell.detailTextLabel?.text = String(format: "%0.2f %@", (coin.estimatedCurrencyReward - (RigData.electricityCost * RigData.power * 24)/1000), LocalDataManager.selectedCurrency + "/day")
        default:
            break
        }
        
        #if PRO
            
        #else
        if indexPath.row > 3 {
            cell.detailTextLabel?.text = "Pro version"
        }
        #endif
        

        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 160
        default:
            return 55
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        #if PRO
            return
        #else
            if indexPath.row > 3 {
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
                        }
                    }
                })
            }
        #endif
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
