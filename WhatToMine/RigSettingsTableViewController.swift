//
//  RigSettingsTableViewController.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/4/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import SVProgressHUD
import Fabric
import Crashlytics

class RigSettingsTableViewController: UITableViewController, SwitchCellDelegate, TextFieldCellDelegate, StepperCellDelegate {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var hashrates:[Double] = {
        var rates = [Double]()
        for item in RigData.algorithms {
            rates.append(item.hashrate)
        }
        return rates
    }()
    
    var stepperValues: [Int] = {
        var values = [Int]()
        for item in RigData.videoCards {
            values.append(item.count)
        }
        return values
    }()
    
    
    var power = {
        return RigData.power
    }()
    
    var cost = {
       return RigData.electricityCost
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Answers.logContentView(withName: "Rig settings scene", contentType: "Rig settings scene", contentId: "Rig settings scene", customAttributes: nil)
        
        #if ASIC
            RigData.advancedMode = true
        #endif
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.navigationController?.viewControllers.first != self {
            self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backButtonTapped))
        }
        
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
        return RigData.algorithms.count + 2
        #else
            return (RigData.advancedMode == true ? RigData.algorithms.count + 3 : RigData.videoCards.count + 2)
        #endif
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var targetIndex = indexPath.row
        
        #if ASIC
        targetIndex = indexPath.row + 1
        #else

        #endif


        if targetIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell") as! SwitchTableViewCell
            cell.cellSwitch.isOn = RigData.advancedMode
            cell.delegate = self
            return cell
        }
        else if targetIndex == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.hashrateTextField.placeholder = "\(LocalDataManager.selectedCurrency)/kWh"
            cell.hashrateTextField.text = "\(RigData.electricityCost)"
            cell.titleLabel.text = "Cost"
            cell.suffixLabel.text = "\(LocalDataManager.selectedCurrency)/kWh"
            cell.delegate = self
            return cell
        }
        else {
            if RigData.advancedMode == true {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                cell.delegate = self
                
                switch targetIndex {
                case 2:
                    cell.hashrateTextField.placeholder = "0.0"
                    cell.hashrateTextField.text = "\(RigData.power)"
                    cell.titleLabel.text = "Power"
                    cell.suffixLabel.text = "W"
                default:
                    let currentAlgorithm = RigData.algorithms[targetIndex-3]
                    cell.hashrateTextField.placeholder = "0.0"
                    cell.hashrateTextField.text = "\(currentAlgorithm.hashrate)"
                    cell.titleLabel.text = currentAlgorithm.name
                    cell.suffixLabel.text = currentAlgorithm.suffix
                    
                }
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
                let currentCard = RigData.videoCards[indexPath.row - 2]
                cell.cardNameLabel.text = currentCard.name
                cell.stepperValue = currentCard.count
                cell.delegate = self
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.endEditing(true)
    }
    
    
    func switchStateChanged(cell: SwitchTableViewCell, sender: UISwitch) {
        RigData.advancedMode = sender.isOn
        self.tableView.reloadData()
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        SVProgressHUD.show()
        RigData.power = 0.0
        RigData.electricityCost = self.cost
        
        for item in RigData.algorithms {
            item.hashrate = 0.0
        }
        
        
        if RigData.advancedMode == false {
            for index in 0..<RigData.videoCards.count {
                let card = RigData.videoCards[index]
                card.count = self.stepperValues[index]
            }
            
            for card in RigData.videoCards {
                RigData.ethash.hashrate += Double(card.count) * card.ethashHR
                RigData.groestl.hashrate += Double(card.count) * card.groestHR
                RigData.x11gost.hashrate += Double(card.count) * card.x11GhostHR
                RigData.cryptonight.hashrate += Double(card.count) * card.cryptoNightHR
                RigData.equihash.hashrate += Double(card.count) * card.equihashHR
                RigData.lyra2re.hashrate += Double(card.count) * card.lyra2REv2HR
                RigData.neoscript.hashrate += Double(card.count) * card.neoScryptHR
                RigData.lbry.hashrate += Double(card.count) * card.lbryHR
                RigData.blake2b.hashrate += Double(card.count) * card.blake2bHR
                RigData.blake14r.hashrate += Double(card.count) * card.blake14rHR
                RigData.pascal.hashrate += Double(card.count) * card.pascalHR
                RigData.skunk.hashrate += Double(card.count) * card.skunkHR
                RigData.power += Double(card.count) * card.power
            }
        }
        else {
            var hasPositiveHashrate = false
            for item in self.hashrates {
                if item > 0 {
                    hasPositiveHashrate = true
                } else if item < 0{
                    SVProgressHUD.showError(withStatus: "All values must be positive numbers")
                }
            }
            guard self.hashrates[0] > 0 else {
                var errorString = "Ethash value must be more than 0.0"
                #if ASIC
                    errorString = "SHA-256 value must be more than 0.0"
                #endif
                SVProgressHUD.showError(withStatus: errorString)
                return
            }
            guard hasPositiveHashrate == true else {
                SVProgressHUD.showError(withStatus: "At least one hashrate must be positive")
                return
            }
            
            RigData.power = self.power
            
            for index in 0..<RigData.algorithms.count {
                RigData.algorithms[index].hashrate = self.hashrates[index]
            }
        }
        
        RigData.defaults.synchronize()
        LocalDataManager.loadAllData { success in
            if success == false {
                SVProgressHUD.showError(withStatus: "Connection problems")
            } else {
                SVProgressHUD.dismiss()
            }
            
            
            if self.navigationController?.viewControllers.first != self {
                self.navigationController?.popViewController(animated: true)
                Answers.logCustomEvent(withName: "Rig Settings Saved", customAttributes: nil)
            } else {
                LocalDataManager.initialSetupCompleted = true
                self.dismiss(animated: true, completion: { 
                    Answers.logLogin(withMethod: "User Aquired", success: true, customAttributes: nil)
                })
            }
            
        }
    }
    
    
    func didChangeText(in cell: TextFieldTableViewCell, text: String) {
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        
        guard let doubleValue = Double(text) else {
            return
        }
        
        var targetIndex = index.row
        
        #if ASIC
            targetIndex += 1
        #endif
        
        switch targetIndex {
        case 0 :
            break
        case 1:
            self.cost = doubleValue
        case 2:
            self.power = doubleValue
        default:
            self.hashrates[targetIndex-3] = doubleValue
        }
    }
    
    func didChangeStepperValue(in cell: CardTableViewCell, value: Int) {
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        
        switch index.row {
        case 0:
            break
        case 1:
            break
        default:
            self.stepperValues[index.row - 2] = value
        }
    }
    
    
    func backButtonTapped() {
        let alertController = UIAlertController(title: "Be careful", message: "Do you want to discard changes?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let confirmAction = UIAlertAction(title: "Discard", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true) { 
            
        }
    }
}
