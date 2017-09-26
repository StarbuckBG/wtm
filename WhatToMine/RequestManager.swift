//
//  RequestManager.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 7/21/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import Foundation


class RequestManager {
    class func loadData(completion: @escaping (Data?)->()) {
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        var coin = "coins"
        
        #if ASIC
            coin = "asic"
        #endif
        
        guard let URL = URL(string: "https://whattomine.com/\(coin).json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        request.addValue(generateHashData(), forHTTPHeaderField: "Cookie")
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                completion(data)
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    class func getSupportedCurrencies(completed: @escaping (_ success: Bool)->()){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         Get supported currencies (GET https://api.coindesk.com/v1/bpi/supported-currencies.json)
         */
        
        guard let URL = URL(string: "https://api.coindesk.com/v1/bpi/supported-currencies.json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                guard data != nil else {
                    completed(false)
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let values = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String:String]]
                        
                        for item in values {
                            try! LocalDataManager.realm.write() {
                                LocalDataManager.realm.create(Currency.self, value: item, update: true)
                            }
                        }
                        completed(true)
                        
                    }
                    catch {
                        print(error)
                        completed(false)
                    }
                }
            }
            else {
                completed(false)
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    class func updateRateForCurrency(_ currency: String, completion: @escaping (_ success: Bool)->()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         CurrentPriceForCurrency (GET https://api.coindesk.com/v1/bpi/currentprice/USD.json)
         */
        
        guard let URL = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/\(currency).json") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                guard data != nil else {
                    completion(false)
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let values = try JSONSerialization.jsonObject(with: data!, options: [])
                        let rates = (values as! [String : Any])["bpi"] as! [String : Any]
                        for item in rates {
                            try! LocalDataManager.realm.write() {
                                LocalDataManager.realm.create(ExchangeRate.self, value: item.value, update: true)
                            }
                        }
                        completion(true)
                        
                    }
                    catch {
                        completion(false)
                        print(error)
                    }
                }
            }
            else {
                // Failure
                completion(false)
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    class func generateHashData() -> String {
        
        var dataDict = [String:Any?]()
        
        dataDict["cost"] = 0.1
        dataDict["sort"] = "Profitability24"
        dataDict["volume"] = "0"
        dataDict["revenue"] = LocalDataManager.selectedDifficulty
        dataDict["exchanges"] = ["","bittrex","bleutrade","btc_e","bter","c_cex","cryptopia","poloniex","yobit"]
        
        #if ASIC
        dataDict["sha256f"] = "true"
        dataDict["scryptf"] = "true"
        dataDict["x11f"] = "true"
        dataDict["qkf"] = "true"
        dataDict["qbf"] = "true"
        
        dataDict["sha256_hr"] = RigData.sha256.hashrate
        dataDict["scrypt_hash_rate"] = RigData.scrypt.hashrate
        dataDict["x11_hr"] = RigData.x11.hashrate
        dataDict["qk_hr"] = RigData.quark.hashrate
        dataDict["qb_hr"] = RigData.qubit.hashrate
        
        #else
        
        dataDict["bk2bf"] = "true"
        dataDict["x11gf"] = "true"
        dataDict["lbry"] = "true"
        dataDict["grof"] = "true"
        dataDict["cn"] = "true"
        dataDict["ns"] = "true"
        dataDict["lre"] = "true"
        dataDict["bkv"] = "true"
        dataDict["bk14"] = "true"
        dataDict["eth"] = "true"
        dataDict["eq"] = "true"
        dataDict["pas"] = "true"
        dataDict["sk"] = "true"
        dataDict["skh"] = "true"
        dataDict["l2z"] = "true"
        
        dataDict["bk2b_hr"] = RigData.blake2b.hashrate
        dataDict["x11g_hr"] = RigData.x11gost.hashrate
        dataDict["lbry_hr"] = RigData.lbry.hashrate
        dataDict["gro_hr"] = RigData.groestl.hashrate
        dataDict["cn_hr"] = RigData.cryptonight.hashrate
        dataDict["ns_hr"] = RigData.neoscript.hashrate
        dataDict["lrev2_hr"] = RigData.lyra2re.hashrate
        dataDict["bkv_hr"] = RigData.blake2b.hashrate
        dataDict["bk14_hr"] = RigData.blake14r.hashrate
        dataDict["eth_hr"] = RigData.ethash.hashrate
        dataDict["eq_hr"] = RigData.equihash.hashrate
        dataDict["pas_hr"] = RigData.pascal.hashrate
        dataDict["skh_hr"] = RigData.skunk.hashrate
        dataDict["sk_hr"] = 0.0
        dataDict["l2z_hr"] = 0.0
        
        #endif
        
        
        
        do {
            let encodedData = try JSONSerialization.data(withJSONObject: dataDict, options: [])
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]{|}[\\]\" ").inverted)
            let string = String(data: encodedData, encoding: String.Encoding.ascii)?.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
            
            var prefix = "gpu"
            #if ASIC
                prefix = "asic"
            #endif
            
            return "wtm_\(prefix)_wtm=" + (string ?? "")
        }
        catch {
            return ""
        }
    }

}
