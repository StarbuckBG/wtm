//
//  CoinTableViewCell.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/1/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import SDWebImage


class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinAlgorithm: UILabel!
    @IBOutlet weak var coinRevenue: UILabel!
    @IBOutlet weak var coinProfit: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.bounds.width < 370.0 {
            self.coinName.font = self.coinName.font.withSize(14)
            self.coinAlgorithm.font = self.coinAlgorithm.font.withSize(14)
            self.coinRevenue.font = self.coinRevenue.font.withSize(14)
            self.coinProfit.font = self.coinProfit.font.withSize(14)
        }
    }
    
    func configure(for coin: CoinData){
        var coinName = coin.name
        if (coinName.contains("Nicehash") == true) {
            coinName = "Nicehash"
        }
        let energyCost = (RigData.electricityCost * RigData.power * 24)/1000
        self.coinName.text = coinName
        self.coinAlgorithm.text = coin.algorithm
        self.coinRevenue.text = String(format: "%0.2f", coin.estimatedCurrencyReward)
        self.coinProfit.text = String(format: "%0.2f", coin.estimatedCurrencyReward - energyCost)
        
        if let image = coin.imageName(), let imageURL = URL(string: image) {
            self.coinImageView.sd_setImage(with: imageURL, completed: { (image, err, cacheType, url) in
            })
        }
    }

}
