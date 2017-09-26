//
//  DonationsTableViewController.swift
//  NicehashStats
//
//  Created by Martin Kuvandzhiev on 7/19/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import Crashlytics


class DonationsTableViewController: UITableViewController {

    var currencyAccountsDict: [(identifier:String,address:String)] =
        [("BTC" , "13f4RKaro4KuPEeCXd4r4iShux9J1e8v1s"),
         ("ETH" , "0xd92d54f6a7938b2999edd7867ae8ecc34cfb533e"),
         ("ETC" , "0x687c502a37261b8db3b0d9bd0b9ea5587651ead6"),
         ("ZEC" , "t1MF1dHZWCkpEHzn7vNLXKiaaGrd44ZXwQz"),
         ("LTC" , "LgPv3zh7vq4nk6kxrinmfPvTaPMFYDQ9KS"),
         ("ZCL" , "t1Ysa2CHdpMu8T2zjYXQNQxPgGh8ehe9QYo"),
         ("ZEN" , "znTuaV88Yrb6vL9Up2QSmUd3BT87vEeV77r"),
         ("DCR" , "DsXKyrSRnnw9dgdX8MdnE4QmX2Q5PPDtWeY"),
         ("SIB" , "SfVmh27BiMHZm1dGMA3Xc4Gd6itYzV7Tb2")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        Answers.logContentView(withName: "Donations scene", contentType: "Donations scene", contentId: "Donations scene", customAttributes: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyAccountsDict.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)

        cell.textLabel?.text = currencyAccountsDict[indexPath.row].identifier
        cell.detailTextLabel?.text = currencyAccountsDict[indexPath.row].address
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let qrViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        
        qrViewController.currencyAddress = currencyAccountsDict[indexPath.row].address
        qrViewController.currencySign = currencyAccountsDict[indexPath.row].identifier
        self.navigationController?.pushViewController(qrViewController, animated: true)
    }

}
