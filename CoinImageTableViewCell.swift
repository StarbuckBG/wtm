//
//  CoinImageTableViewCell.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/15/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit

class CoinImageTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
