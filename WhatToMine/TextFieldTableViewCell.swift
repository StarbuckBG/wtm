//
//  HashrateTableViewCell.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/4/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import TextFieldEffects

protocol TextFieldCellDelegate: class{
    func didChangeText(in cell: TextFieldTableViewCell, text: String)
}

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var hashrateTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var suffixLabel: UILabel!
    
    var delegate: TextFieldCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.hashrateTextField.layer.borderWidth = 1
        self.hashrateTextField.layer.borderColor = UIColor.appTeal.cgColor
        self.hashrateTextField.layer.cornerRadius = 5
        self.hashrateTextField.delegate = self
    }


    @IBAction func donePressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textString = textField.text else {
            return true
        }
        
        let text = NSString(string: textString).replacingCharacters(in: range, with: string)
        
        if let _ = Double(text) {
            self.hashrateTextField.layer.borderColor = UIColor.appTeal.cgColor
        } else {
            self.hashrateTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        self.delegate?.didChangeText(in: self, text: text)
        return true
    }
    
}
