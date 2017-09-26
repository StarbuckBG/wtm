//
//  Extensions.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/2/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit


extension UIColor{
    class var appTeal: UIColor {
        // 26A69A
        
        return UIColor(red: 0.149, green: 0.651, blue: 0.604, alpha: 1.0)
    }
}






extension UINavigationBar {
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }
    
    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
}

extension UIToolbar {
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }
    
    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
}

extension UIView {
    fileprivate var hairlineImageView: UIImageView? {
        return hairlineImageView(in: self)
    }
    
    fileprivate func hairlineImageView(in view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
            return imageView
        }
        
        for subview in view.subviews {
            if let imageView = self.hairlineImageView(in: subview) { return imageView }
        }
        
        return nil
    }
}
