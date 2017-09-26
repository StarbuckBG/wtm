//
//  QRCodeViewController.swift
//  NicehashStats
//
//  Created by Martin Kuvandzhiev on 7/19/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import QRCode

class QRCodeViewController: UIViewController {

    @IBOutlet weak var qrCodeView: UIImageView!
    @IBOutlet weak var currencySignLabel: UILabel!
    @IBOutlet weak var currencyAddressLabel: UILabel!
    
    var currencyAddress: String! = ""
    var currencySign: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let qrCode = QRCode(currencyAddress)
        self.qrCodeView.image = qrCode?.image
        self.currencySignLabel.text = currencySign
        self.currencyAddressLabel.text = currencyAddress
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
