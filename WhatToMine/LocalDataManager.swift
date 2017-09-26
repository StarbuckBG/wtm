//
//  LocalDataManager.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 7/21/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import Foundation
import RealmSwift


class LocalDataManager{

    static let realm: Realm = try! Realm(configuration: realmConfiguration)
    static let realmConfiguration:Realm.Configuration = {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.migrationBlock = { (migration, shemaVersion) in
            
        }
        
        configuration.schemaVersion = 3
        return configuration
    }()
    
    
    static var backgroundRealm: Realm {
        return try! Realm()
    }

    
    static var selectedCurrency: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedCurrency")
        }
        get {
            return UserDefaults.standard.string(forKey: "selectedCurrency") ?? "USD"
        }
    }
    
    static var selectedDifficulty: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "difficultyForRevenue")
        }
        get {
            return UserDefaults.standard.string(forKey: "difficultyForRevenue") ?? DifficultyForRevenue.current.rawValue
        }
    }
    
    static var allCurrenciesUnlocked: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "unlockAllCurrenciesWTM")
        }
        get {
            return UserDefaults.standard.bool(forKey: "unlockAllCurrenciesWTM")
        }
    }
    
    static var initialSetupCompleted: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "initialSetupCompleted")
        }
        get {
            return UserDefaults.standard.bool(forKey: "initialSetupCompleted")
        }
    }

    
    class func loadAllData(completion: @escaping (_ success: Bool)->()) {
        RequestManager.loadData { (data) in
            guard let data = data else {
                return
            }
            let coinObject = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            guard let coins = coinObject["coins"] as? [String:Any] else {
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                self.realm.beginWrite()
                self.realm.deleteAll()
                for coin in coins {
                    var coinData = coin.value as! [String:Any]
                    coinData["name"] = coin.key
                    
                    if coinData["block_time"] is Int {
                        coinData["block_time"] = nil
                    }
                    
                    if coinData["nethash"] is Double {
                        coinData["nethash"] = "\(coinData["nethash"] as! Double)"
                    }
                    
                    
                    self.realm.create(CoinData.self, value: coinData, update: true)
                }
                try! self.realm.commitWrite()
                loadSupportedCurrencies()
                
                updateRateForUserSelectedCurrency(completion: {
                    success in
                    completion(true)
                })
                
            }
        }
    }
    
    class func loadSupportedCurrencies() {
        RequestManager.getSupportedCurrencies { (completed) in
            NotificationCenter.default.post(name: NSNotification.Name("CurrenciesLoaded"), object: nil)
        }
    }
    
    class func updateRateForUserSelectedCurrency(completion: ((_ success: Bool)->())?) {
        RequestManager.updateRateForCurrency(selectedCurrency, completion: { success in
            NotificationCenter.default.post(name: NSNotification.Name("CurrenciesUpdated"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("AppDataReload"), object: nil)
            completion?(success)
        })
    }

}
