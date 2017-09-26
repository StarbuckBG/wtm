//
//  CardTableViewCell.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/4/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit

protocol StepperCellDelegate: class {
    func didChangeStepperValue(in cell: CardTableViewCell, value: Int)
}

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardPieces: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    weak var delegate: StepperCellDelegate?
    
    var stepperValue: Int {
        set {
            self.stepper.value = Double(newValue)
            self.cardPieces.text = "\(Int(self.stepper.value)) pcs"
            self.cardPieces.alpha = newValue == 0 ? 0.4 : 1
        }
        get {
            return Int(self.stepper.value)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func stepperChanged(_ sender: UIStepper) {
        self.stepperValue = Int(sender.value)
        delegate?.didChangeStepperValue(in: self, value: self.stepperValue)
    }
    
}
