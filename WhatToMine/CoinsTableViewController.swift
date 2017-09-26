//
//  CoinsTableViewController.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/1/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import SVProgressHUD
import Crashlytics
import StoreKit

class CoinsTableViewController: UITableViewController {

    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var headerLeftLabel: UILabel!
    @IBOutlet weak var headerRightLabel: UILabel!
    
    lazy var coinData = {
        return LocalDataManager.realm.objects(CoinData.self).sorted(byKeyPath: "profitability", ascending: false).filter("profitability != %f", 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.hideBottomHairline()
        
        
        self.tableView.tableHeaderView = self.headerView
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AppDataReload"), object: nil, queue: nil) { (notification) in
            self.coinData = LocalDataManager.realm.objects(CoinData.self).sorted(byKeyPath: "profitability", ascending: false).filter("profitability != %f", 0)
            self.tableView.reloadData()
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSForegroundColorAttributeName:UIColor.white])
        self.refreshControl?.backgroundColor = self.tableView.separatorColor
        self.refreshControl?.tintColor = UIColor.white
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.headerLeftLabel.text = "Current profitability"
        self.headerRightLabel.text = "\(LocalDataManager.selectedCurrency)/day"
        LocalDataManager.loadAllData { success in
            if success == false {
                SVProgressHUD.showError(withStatus: "Connection problems")
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Answers.logContentView(withName: "Coins scene", contentType: "Coins scene", contentId: "Coins scene", customAttributes: nil)
        
        if LocalDataManager.initialSetupCompleted == false {
            self.navigationController?.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetupRigNavigationController"), animated: true, completion: { 
                
            })
        }
        
        if let dateOfFirstRun = UserDefaults.standard.object(forKey: "dateOfFirstRun") as? Date {
            if Date().timeIntervalSince(dateOfFirstRun) > 1 * 7 * 24 * 60 * 60 {
                if #available(iOS 10.3, *) {
                    UserDefaults.standard.set(Date(), forKey: "dateOfFirstRun")
                    SKStoreReviewController.requestReview()
                }
            }
        } else {
            UserDefaults.standard.set(Date(), forKey: "dateOfFirstRun")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCoinDetailsSegue" {
            guard let destination = segue.destination as? CoinDetailsTableViewController else {
                return
            }
            
            guard let coinData = sender as? CoinData else {
                return
            }
            
            destination.coin = coinData
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCellIdentifier", for: indexPath) as! CoinTableViewCell
        cell.configure(for: self.coinData[indexPath.row])

        cell.accessoryType = .disclosureIndicator
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "toCoinDetailsSegue", sender: self.coinData[indexPath.row])
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    func refreshData() {
        Answers.logCustomEvent(withName: "Refresh initiated", customAttributes: nil)
        
        LocalDataManager.loadAllData { _ in
            self.refreshControl?.endRefreshing()
        }
    }
   
}
