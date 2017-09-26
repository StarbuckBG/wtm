//
//  CurrenciesTableViewController.swift
//  NicehashStats
//
//  Created by Martin Kuvandzhiev on 7/29/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import SVProgressHUD
import StoreKit
import Crashlytics

class CurrenciesTableViewController: UITableViewController, SKStoreProductViewControllerDelegate {
    
    
    lazy var data: [String] = {
        let basicCurrencies = LocalDataManager.realm.objects(Currency.self).filter("currency == %@ || currency == %@ || currency == %@", "USD", "EUR", "GBP").sorted(byKeyPath: "currency", ascending: false)
        
       let currencies = LocalDataManager.realm.objects(Currency.self).sorted(byKeyPath: "currency")
        
        var currencyArray = [String]()
        for item in basicCurrencies {
            currencyArray.append(item.currency)
        }
        
        for item in currencies {
            currencyArray.append(item.currency)
        }
        return currencyArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        
        cell.textLabel?.text = self.data[indexPath.row]
        if self.data[indexPath.row] == LocalDataManager.selectedCurrency {
            cell.detailTextLabel?.text = "Selected"
        } else {
            cell.detailTextLabel?.text = ""
            #if PRO
                
            #else
                if indexPath.row >= 3 {
                    cell.detailTextLabel?.text = "Pro version"
                }
            #endif
            }
        
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        #if PRO
            SVProgressHUD.show()
            let currentCurrency = LocalDataManager.selectedCurrency
            LocalDataManager.selectedCurrency = self.data[indexPath.row]
            LocalDataManager.updateRateForUserSelectedCurrency(completion: { success in
                if success == true {
                    SVProgressHUD.showSuccess(withStatus: "Successfuly changed")
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    LocalDataManager.selectedCurrency = currentCurrency
                    self.tableView.reloadData()
                    SVProgressHUD.showError(withStatus: "No internet connection. Try again :/")
                }
            })
        #else
            if indexPath.row < 3 {
                SVProgressHUD.show()
                let currentCurrency = LocalDataManager.selectedCurrency
                LocalDataManager.selectedCurrency = self.data[indexPath.row]
                LocalDataManager.updateRateForUserSelectedCurrency(completion: { success in
                    if success == true {
                        SVProgressHUD.showSuccess(withStatus: "Successfuly changed")
                        self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        LocalDataManager.selectedCurrency = currentCurrency
                        self.tableView.reloadData()
                        SVProgressHUD.showError(withStatus: "No internet connection. Try again :/")
                    }
                })
            }
            else {
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
            }
        #endif
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
