//
//  AdvancedTableViewCell.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/4/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate: class {
    func switchStateChanged(cell: SwitchTableViewCell, sender: UISwitch)
}

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSwitch: UISwitch!
    
    var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        self.delegate?.switchStateChanged(cell: self, sender: sender)
    }
}
