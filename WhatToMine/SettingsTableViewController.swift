//
//  SettingsTableViewController.swift
//  NicehashStats
//
//  Created by Martin Kuvandzhiev on 7/14/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import SVProgressHUD

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate,  SKStoreProductViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
        #if ASIC
            return 6
        #else
            return 7
        #endif
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Selected currency"
            cell.detailTextLabel?.text = LocalDataManager.selectedCurrency
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "Rig hashrate settings"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = "Difficulty for revenue"
            cell.detailTextLabel?.text = LocalDataManager.selectedDifficulty
            cell.accessoryType = .disclosureIndicator
        case 3:
            cell.textLabel?.text = "Version"
            cell.detailTextLabel?.text = "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "") (\(Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? ""))"
            cell.accessoryType = .none
        case 4:
            cell.textLabel?.text = "Request a feature"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
        case 5:
            cell.textLabel?.text = "Contact developer"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
        case 6:
            cell.textLabel?.text = "WhatToMine ASIC Edition"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "selectCurrencySegue", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "showRigSettingsSegue", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "selectDifficultySegue", sender: nil)
        case 3:
            break
        case 4:
            let composer = MFMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail() {
                composer.mailComposeDelegate = self
                composer.setToRecipients(["whattomine@rapiddevcrew.com"])
                composer.setSubject("Feature request")
                composer.setMessageBody("Input you feature request", isHTML: false)
                present(composer, animated: true, completion: nil)
            }
        case 5:
            let composer = MFMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail() {
                composer.mailComposeDelegate = self
                composer.setToRecipients(["whattomine@rapiddevcrew.com"])
                composer.setSubject("User feedback")
                composer.setMessageBody("Input you message", isHTML: false)
                present(composer, animated: true, completion: nil)
            }
        case 6:
            SVProgressHUD.show()
            let storeProductViewController = SKStoreProductViewController()
            storeProductViewController.delegate = self
            
            let parametersDict = [SKStoreProductParameterITunesItemIdentifier: 1286634036]
            
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
            
        default:
            break
        }

    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
