//
//  RigData.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 8/3/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import Foundation

enum CoinSortOptions: String {
    case profitability24 = "Profitability24"
}


enum DifficultyForRevenue: String {
    case current = "current"
    case c24h = "24h"
    case c3d = "3d"
    case c7d = "7d"
    
    var description:String {
        switch self {
        case .current:
            return "Current"
        case .c24h:
            return "Average 24 hours"
        case .c3d:
            return "Average 3 days"
        case .c7d:
            return "Average 7 days"
        }
    }
}

class RigData {
    
    static let defaults = UserDefaults.standard
    
    
    class var power: Double {
        get {
            return defaults.double(forKey: "power")
        }
        set {
            defaults.set(newValue, forKey: "power")
        }
    }
    
    
    class var electricityCost: Double {
        get {
            let value = defaults.double(forKey: "electricityCost")
            return value != 0 ? value : 0.1
        }
        set {
            defaults.set(newValue, forKey: "electricityCost")
        }
    }
    
    class var advancedMode: Bool {
        get {
            return defaults.bool(forKey: "advancedMode")
        }
        set {
            defaults.set(newValue, forKey: "advancedMode")
        }
    }
    
    
    
    
    static let videoCards = [rx470, rx480, rx570, rx580,gtx1050ti, gtx1060, gtx1070, gtx1080, gtx1080ti, gtx960, gtx970 , gtx980, gtx980ti, gtx750ti, hd7870, hd7950 ,r7360,r7370, r280x,r9290x, r9380, r380, r9390, fury, rx460, rx560]
    
    static let r280x = VideoCardData(name: "R9 280X", power: 250, ethashHR: 11.0, groestHR: 23.8, x11GhostHR: 2.9, cryptoNightHR: 490.0, equihashHR: 290.0, lyra2REv2HR: 14050, neoScryptHR: 490, lbryHR: 60, blake2bHR: 960, blake14rHR: 1450, pascalHR: 580, skunkHR: 0.0)
    
    static let r380 = VideoCardData(name: "R9 380X", power: 140, ethashHR: 20, groestHR: 15.5, x11GhostHR: 2.5, cryptoNightHR: 530, equihashHR: 205, lyra2REv2HR: 6400, neoScryptHR: 350, lbryHR: 44, blake2bHR: 760, blake14rHR: 1140, pascalHR: 480.0, skunkHR: 9.0)
    
    static let fury = VideoCardData(name: "R9 Fury", power: 180, ethashHR: 29.2, groestHR: 17.4, x11GhostHR: 4.5, cryptoNightHR: 800, equihashHR: 455, lyra2REv2HR: 14200, neoScryptHR: 500, lbryHR: 83, blake2bHR: 1400, blake14rHR: 1900, pascalHR: 950, skunkHR: 0.0)
    
    static let rx470 = VideoCardData(name: "RX 470", power: 120, ethashHR: 25.0, groestHR: 17.0, x11GhostHR: 5.3, cryptoNightHR: 660.0, equihashHR: 260.0, lyra2REv2HR: 4400, neoScryptHR: 600, lbryHR: 80, blake2bHR: 940, blake14rHR: 1600, pascalHR: 560, skunkHR: 15.0)
    
    static let rx480 = VideoCardData(name: "RX 480", power: 135, ethashHR: 29.0, groestHR: 21.3, x11GhostHR: 6.7, cryptoNightHR: 730, equihashHR: 290, lyra2REv2HR: 4900, neoScryptHR: 650, lbryHR: 105, blake2bHR: 1150, blake14rHR: 1970, pascalHR: 700, skunkHR: 18.0)
    
    static let rx570 = VideoCardData(name: "RX 570", power: 130, ethashHR: 26.0, groestHR: 17.0, x11GhostHR: 5.3, cryptoNightHR: 660.0, equihashHR: 260.0, lyra2REv2HR: 4400, neoScryptHR: 600, lbryHR: 80, blake2bHR: 940, blake14rHR: 1600, pascalHR: 560, skunkHR: 18.2)
    
    static let rx580 = VideoCardData(name: "RX 580", power: 135, ethashHR: 27.0, groestHR: 21.3, x11GhostHR: 6.7, cryptoNightHR: 730, equihashHR: 290, lyra2REv2HR: 4900, neoScryptHR: 650, lbryHR: 105, blake2bHR: 1150, blake14rHR: 1970, pascalHR: 700, skunkHR: 20.1)
    
    static let gtx1060 = VideoCardData(name: "GTX 1060", power: 90, ethashHR: 21.3, groestHR: 20.5, x11GhostHR: 7.2, cryptoNightHR: 430, equihashHR: 270, lyra2REv2HR: 20300, neoScryptHR: 500, lbryHR: 170, blake2bHR: 990, blake14rHR: 1550, pascalHR: 580, skunkHR: 18.0)
    
    static let gtx1070 = VideoCardData(name: "GTX 1070", power: 110, ethashHR: 28.5, groestHR: 35.5, x11GhostHR: 11.5, cryptoNightHR: 500, equihashHR: 420, lyra2REv2HR: 35500, neoScryptHR: 1050, lbryHR: 275, blake2bHR: 1600, blake14rHR: 2500, pascalHR: 940, skunkHR: 26.5)
    
    static let gtx1080 = VideoCardData(name: "GTX 1080", power: 140, ethashHR: 23.3, groestHR: 44.5, x11GhostHR: 13.5, cryptoNightHR: 580.0, equihashHR: 450.0, lyra2REv2HR: 46500, neoScryptHR: 1050, lbryHR: 360, blake2bHR: 2050, blake14rHR: 3300, pascalHR: 1250, skunkHR: 36.5)
    
    static let gtx1080ti = VideoCardData(name: "GTX 1080Ti", power: 170, ethashHR: 35, groestHR: 58, x11GhostHR: 19.5, cryptoNightHR: 830, equihashHR: 635, lyra2REv2HR: 64000, neoScryptHR: 1400, lbryHR: 460, blake2bHR: 2750, blake14rHR: 4350, pascalHR: 1700, skunkHR: 47.5)
    
    
    static let hd7870 = VideoCardData(name: "AMD HD 7870", power: 195, ethashHR: 0.0, groestHR: 17.2, x11GhostHR: 1.4, cryptoNightHR: 390, equihashHR: 145, lyra2REv2HR: 7400, neoScryptHR: 280, lbryHR: 30, blake2bHR: 0.0, blake14rHR: 630, pascalHR: 350, skunkHR: 0.0)
    
    static let r7360 = VideoCardData(name: "R7 360", power: 80, ethashHR: 0.0, groestHR: 10.1, x11GhostHR: 1, cryptoNightHR: 200, equihashHR: 102, lyra2REv2HR: 0.0, neoScryptHR: 0.0, lbryHR: 30, blake2bHR: 0.0, blake14rHR: 290, pascalHR: 250, skunkHR: 0.0)
    
    static let hd7950 = VideoCardData(name: "AMD HD 7950", power: 170, ethashHR: 0.0, groestHR: 0.0, x11GhostHR: 1.7, cryptoNightHR: 560, equihashHR: 250, lyra2REv2HR: 10300, neoScryptHR: 0.0, lbryHR: 50, blake2bHR: 0.0, blake14rHR: 560, pascalHR: 500, skunkHR: 0.0)
    
    static let r7370 = VideoCardData(name: "R7 370", power: 95, ethashHR: 0.0, groestHR: 0.0, x11GhostHR: 1.1, cryptoNightHR: 420, equihashHR: 150, lyra2REv2HR: 6700, neoScryptHR: 200, lbryHR: 40, blake2bHR: 0.0, blake14rHR: 520, pascalHR: 280, skunkHR: 0.0)
    
    static let r9290x = VideoCardData(name: "R9 290X", power: 320, ethashHR: 25.75, groestHR: 0.0, x11GhostHR: 3.8, cryptoNightHR: 760, equihashHR: 350, lyra2REv2HR: 16400, neoScryptHR: 0.0, lbryHR: 70, blake2bHR: 0.0, blake14rHR: 1070, pascalHR: 750, skunkHR: 0.0)
    
    static let r9380 = VideoCardData(name: "R9 380", power: 220, ethashHR: 18.0, groestHR: 0.0, x11GhostHR: 2.5, cryptoNightHR: 480, equihashHR: 168.45, lyra2REv2HR: 6200, neoScryptHR: 270, lbryHR: 40, blake2bHR: 0.0, blake14rHR: 660, pascalHR: 550, skunkHR: 0.0)
    
    static let r9390 = VideoCardData(name: "R9 390", power: 300, ethashHR: 29.2, groestHR: 0.0, x11GhostHR: 3.4, cryptoNightHR: 810, equihashHR: 380, lyra2REv2HR: 0.0, neoScryptHR: 0.0, lbryHR: 60, blake2bHR: 0.0, blake14rHR: 950, pascalHR: 750, skunkHR: 0.0)
    
    static let rx460 = VideoCardData(name: "RX 460", power: 80, ethashHR: 10.65, groestHR: 0.0, x11GhostHR: 2.8, cryptoNightHR: 330, equihashHR: 110, lyra2REv2HR: 0.0, neoScryptHR: 0.0, lbryHR: 0.0, blake2bHR: 0.0, blake14rHR: 0.0, pascalHR: 300, skunkHR: 0.0)
    
    static let rx560 = VideoCardData(name: "RX 560", power: 70, ethashHR: 11.2, groestHR: 0.0, x11GhostHR: 3.0, cryptoNightHR: 350, equihashHR: 120, lyra2REv2HR: 0.0, neoScryptHR: 0.0, lbryHR: 0.0, blake2bHR: 0.0, blake14rHR: 0.0, pascalHR: 310, skunkHR: 0.0)
    
    static let gtx750ti = VideoCardData(name: "GTX 750ti", power: 85, ethashHR: 0.0, groestHR: 0.0, x11GhostHR: 2.6, cryptoNightHR: 250, equihashHR: 74.4, lyra2REv2HR: 6540, neoScryptHR: 160, lbryHR: 50, blake2bHR: 0, blake14rHR: 510, pascalHR: 180, skunkHR: 0.0)
    
    static let gtx960 = VideoCardData(name: "GTX 960", power: 100, ethashHR: 0.0, groestHR: 0.0, x11GhostHR: 4.8, cryptoNightHR: 270, equihashHR: 141, lyra2REv2HR: 14.4, neoScryptHR: 0.0, lbryHR: 100, blake2bHR: 0.0, blake14rHR: 920, pascalHR: 360, skunkHR: 0.0)
    
    static let gtx970 = VideoCardData(name: "GTX 970", power: 140, ethashHR: 22.2, groestHR: 0.0, x11GhostHR: 7.7, cryptoNightHR: 480, equihashHR: 290, lyra2REv2HR: 23550, neoScryptHR: 0.0, lbryHR: 160, blake2bHR: 0.0, blake14rHR: 1510, pascalHR: 570, skunkHR: 0.0)
    
    static let gtx980 = VideoCardData(name: "GTX 980", power: 220, ethashHR: 20.28, groestHR: 0.0, x11GhostHR: 8.8, cryptoNightHR: 540, equihashHR: 312, lyra2REv2HR: 26970, neoScryptHR: 740, lbryHR: 180, blake2bHR: 0.0, blake14rHR: 1740, pascalHR: 650, skunkHR: 0.0)
    
    static let gtx980ti = VideoCardData(name: "GTX 980ti", power: 235, ethashHR: 21.57, groestHR: 0.0, x11GhostHR: 13.3, cryptoNightHR: 700, equihashHR: 461, lyra2REv2HR: 36910, neoScryptHR: 1000, lbryHR: 240, blake2bHR: 0.0, blake14rHR: 2400, pascalHR: 980, skunkHR: 0.0)
    
    static let gtx1050ti = VideoCardData(name: "GTX 1050ti", power: 60, ethashHR: 12.6, groestHR: 0.0, x11GhostHR: 4.5, cryptoNightHR: 300, equihashHR: 156, lyra2REv2HR: 12920, neoScryptHR: 360, lbryHR: 110, blake2bHR: 0.0, blake14rHR: 1000, pascalHR: 360, skunkHR: 0.0)
    
    
    
    static let ethash = AlgorithmData(name: "Ethash", suffix: "Mh/s")
    static let groestl = AlgorithmData(name: "Groestl", suffix: "Mh/s")
    static let x11gost = AlgorithmData(name: "X11Gost", suffix: "Mh/s")
    static let cryptonight = AlgorithmData(name: "CryptoNight", suffix: "h/s")
    static let equihash = AlgorithmData(name: "Equihash", suffix: "h/s")
    static let lyra2re = AlgorithmData(name: "Lyra2REv2", suffix: "kh/s")
    static let neoscript = AlgorithmData(name: "NeoScrypt", suffix: "kh/s")
    static let lbry = AlgorithmData(name: "LBRY", suffix: "Mh/s")
    static let blake2b = AlgorithmData(name: "Blake (2b)", suffix: "Mh/s")
    static let blake14r = AlgorithmData(name: "Blake (13r)", suffix: "Mh/s")
    static let pascal = AlgorithmData(name: "Pascal", suffix: "Mh/s")
    static let skunk = AlgorithmData(name: "Skunkhash", suffix: "Mh/s")
    
    //ASIC
    static let sha256 = AlgorithmData(name: "SHA-256", suffix: "Gh/s")
    static let scrypt = AlgorithmData(name: "Scrypt", suffix: "Mh/s")
    static let x11 = AlgorithmData(name: "X11", suffix: "Mh/s")
    static let quark = AlgorithmData(name: "Quark", suffix: "Mh/s")
    static let qubit = AlgorithmData(name: "Qubit", suffix: "Mh/s")
    
    #if ASIC
    static let algorithms = [sha256, scrypt, x11, quark, qubit]
    #else
    static let algorithms = [ethash, groestl, x11gost, cryptonight, equihash, lyra2re, neoscript, lbry, blake2b, blake14r, pascal, skunk]
    #endif
    
    
    
    
}

class VideoCardData {
    var name: String
    var power: Double
    var ethashHR: Double
    var groestHR: Double
    var x11GhostHR: Double
    var cryptoNightHR: Double
    var equihashHR: Double
    var lyra2REv2HR: Double
    var neoScryptHR: Double
    var lbryHR: Double
    var blake2bHR: Double
    var blake14rHR: Double
    var pascalHR: Double
    var skunkHR: Double
    
    var count: Int{
        get {
            return RigData.defaults.integer(forKey: self.name)
        }
        set {
            RigData.defaults.set(newValue, forKey: self.name)
            RigData.defaults.synchronize()
        }
    }
    
    init(name: String, power: Double, ethashHR: Double, groestHR: Double, x11GhostHR: Double, cryptoNightHR: Double, equihashHR: Double, lyra2REv2HR: Double, neoScryptHR: Double, lbryHR: Double, blake2bHR: Double, blake14rHR: Double, pascalHR: Double, skunkHR: Double) {
        self.name = name
        self.power = power
        self.ethashHR = ethashHR
        self.groestHR = groestHR
        self.x11GhostHR = x11GhostHR
        self.cryptoNightHR = cryptoNightHR
        self.equihashHR = equihashHR
        self.lyra2REv2HR = lyra2REv2HR
        self.neoScryptHR = neoScryptHR
        self.lbryHR = lbryHR
        self.blake2bHR = blake2bHR
        self.blake14rHR = blake14rHR
        self.pascalHR = pascalHR
        self.skunkHR = skunkHR
    }
}

class AlgorithmData {
    var name: String
    var suffix: String
    var hashrate: Double {
        get {
            return RigData.defaults.double(forKey: self.name)
        }
        set {
            RigData.defaults.set(newValue, forKey: self.name)
            RigData.defaults.synchronize()
        }
    }
    
    init(name: String, suffix: String) {
        self.name = name
        self.suffix = suffix
    }
}
