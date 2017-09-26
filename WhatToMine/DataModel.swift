//
//  DataModel.swift
//  WhatToMine
//
//  Created by Martin Kuvandzhiev on 7/21/17.
//  Copyright © 2017 Rapid Development Crew. All rights reserved.
//

import UIKit
import RealmSwift

class CoinData: Object {
    dynamic var id = 0
    dynamic var tag = ""
    dynamic var algorithm = ""
    dynamic var block_time = ""
    dynamic var block_reward = 0.00
    dynamic var block_reward24 = 0.00
    dynamic var last_block = 0
    dynamic var difficulty = 0.00
    dynamic var difficulty24 = 0.00
    dynamic var nethash = ""
    dynamic var exchange_rate = 0.00
    dynamic var exchange_rate24 = 0.00
    dynamic var exchange_rate_vol = 0.00
    dynamic var exchange_rate_curr = ""
    dynamic var market_cap = ""
    dynamic var estimated_rewards = ""
    dynamic var estimated_rewards24 = ""
    dynamic var btc_revenue = ""
    dynamic var btc_revenue24 = ""
    dynamic var profitability = 0
    dynamic var profitability24 = 0
    dynamic var lagging = false
    dynamic var timestamp = 0
    dynamic var name = ""
    
    var estimatedCurrencyReward: Double {
        let estimatedRewards = LocalDataManager.selectedDifficulty == DifficultyForRevenue.current.rawValue ? (Double(self.btc_revenue) ?? 0.0) : (Double(self.btc_revenue24) ?? 0.0)
        
        if let usdValue = LocalDataManager.realm.object(ofType: ExchangeRate.self, forPrimaryKey: LocalDataManager.selectedCurrency) {
            return estimatedRewards * Double(usdValue.rateFloat)
        }
        else {
            return estimatedRewards * 2500.0
        }
        
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}


class ExchangeRate: Object {
    dynamic var code = ""
    dynamic var symbol = ""
    dynamic var rate = ""
    var rateFloat :Float {
        get {
            return self.rate_float
        }
    }
    
    dynamic var rate_float = Float()
    override static func primaryKey() -> String? {
        return "code"
    }
}

class Currency: Object {
    dynamic var currency = ""
    dynamic var country = ""
    
    override static func primaryKey() -> String? {
        return "currency"
    }
}







extension CoinData{
    
    func imageName() -> String? {
        
        if self.name.lowercased().contains("Nicehash".lowercased()) {
            return "https://images.whattomine.com/nice_hash_coins/logos/000/000/021/medium/nicehash2.png"
        }
        
        var suffix = ""
        switch self.id {
        case 1:
            suffix = "btclogo.png"
        case 162:
            suffix = "etc3.png"
        case 34:
            suffix = "dash-darkcoin.png"
        case 4:
            suffix = "litecoin-logo.png"
        case 166:
            suffix = "zec.png"
        case 101:
            suffix = "monero.png"
        case 178:
            suffix = "music.png"
        case 151:
            suffix = "eth.png"
        case 8:
            suffix = "feathercoin_logo_256px.png"
        case 173:
            suffix = "ubq.png"
        case 185:
            suffix = "zen.png"
        case 174:
            suffix = "kmd.png"
        case 154:
            suffix = "exp2.png"
        case 168:
            suffix = "hush2.png"
        case 169:
            suffix = "sib2.png"
        case 189:
            suffix = "soil.png"
        case 152:
            suffix = "dcr3.png"
        case 164:
            suffix = "lbc2.png"
        case 167:
            suffix = "zcl.png"
        case 48:
            suffix = "grs2.png"
        case 103:
            suffix = "bcn.png"
        case 71:
            suffix = "pxc.png"
        case 177:
            suffix = "pasl.png"
        case 176:
            suffix = "krb.png"
        case 72:
            suffix = "orb.png"
        case 43:
            suffix = "dmd1.png"
        case 161:
            suffix = "sc.png"
        case 5:
            suffix = "vtc.png"
        case 148:
            suffix = "mona.png"
        case 172:
            suffix = "pasc.png"
        case 32, 49, 56:
            suffix = "myr.png"
        case 104:
            suffix = "xdn4.png"
        case 191:
            suffix = "sigt3.png"
        case 65:
            suffix = "aid.png"
        case 157:
            suffix = "adz.png"
        case 192:
            suffix = "aeon.png"
        case 133:
            suffix = "amber.png"
        case 145:
            suffix = "ams.png"
        case 170:
            suffix = "arg2.png"
        case 158:
            suffix = "arg.png"
        case 110:
            suffix = "ari.png"
        case 40:
            suffix = "aur.png"
        case 193:
            suffix = "bcc.png"
        case 103:
            suffix = "bcn.png"
        case 182:
            suffix = "bela.png"
        case 171:
            suffix = "bip3.png"
        case 131:
            suffix = "bob2.png"
        case 138:
            suffix = "bsty.png"
        case 144:
            suffix = "bta2.png"
        case 111:
            suffix = "btm.png"
        case 90:
            suffix = "burn.png"
        case 97:
            suffix = "cach3.png"
        case 120:
            suffix = "cap.png"
        case 198:
            suffix = "cat.png"
        case 126:
            suffix = "cgb.png"
        case 116:
            suffix = "child.png"
        case 188:
            suffix = "cann.png"
        case 123:
            suffix = "ckc.png"
        case 88:
            suffix = "cloak2.png"
        case 199:
            suffix = "logo-CREA-basic-502.png"
        case 165:
            suffix = "crw2.png"
        case 86:
            suffix = "cry2.png"
        case 134:
            suffix = "cto.png"
        case 76:
            suffix = "cure.png"
        case 180:
            suffix = "dem.png"
        case 28, 112, 113, 114, 115:
            suffix = "digibytelogo.png"
        case 27, 125, 124:
            suffix = "dgc.png"
        case 153:
            suffix = "dnet.png"
        case 187:
            suffix = "dnr.png"
        case 6:
            suffix = "dogecoin-300.png"
        case 61:
            suffix = "dope.png"
        case 183:
            suffix = "dp.png"
        case 129:
            suffix = "dsh.png"
        case 140, 141:
            suffix = "duo.png"
        case 19:
            suffix = "earthCoin.png"
        case 15:
            suffix = "Einsteinium.png"
        case 79:
            suffix = "enc.png"
        case 136:
            suffix = "epc2.png"
        case 20:
            suffix = "execoin.png"
        case 102:
            suffix = "fcn2.png"
        case 36:
            suffix = "flt.png"
        case 118:
            suffix = "frsh.png"
        case 63:
            suffix = "fst.png"
        case 147:
            suffix = "gmc.png"
        case 160:
            suffix = "gb.png"
        case 50:
            suffix = "gdn.png"
        case 135:
            suffix = "geo.png"
        case 81:
            suffix = "glc.png"
        case 87:
            suffix = "goal.png"
        case 122:
            suffix = "hal3.png"
        case 33:
            suffix = "HIRO2.png"
        case 35:
            suffix = "heavycoin-logo.png"
        case 142:
            suffix = "iec2.png"
        case 149:
            suffix = "infx.png"
        case 80:
            suffix = "jpc.png"
        case 38:
            suffix = "karm.png"
        case 54:
            suffix = "uno.png"
        case 107:
            suffix = "VIA.png"
        case 195:
            suffix = "linx.png"
        case 132:
            suffix = "start.png"
        case 159:
            suffix = "smc.png"
        case 119:
            suffix = "moon.png"
        case 40:
            suffix = "aur.png"
        case 144:
            suffix = "bta2.png"
        case 157:
            suffix = "adz.png"
        case 137:
            suffix = "qrk2.png"
        case 146:
            suffix = "note.png"
        case 53:
            suffix = "zet.png"
        case 194:
            suffix = "onix.png"
        case 143:
            suffix = "mue2.png"
        case 149:
            suffix = "infx.png"
        case 188:
            suffix = "cann.png"
        case 150:
            suffix = "xvg.png"
        case 190:
            suffix = "pxi.png"
        case 70:
            suffix = "mzc.png"
        case 193:
            suffix = "bcc.png"
        case 52:
            suffix = "ppc.png"
        case 180:
            suffix = "dem.png"
        case 196:
            suffix = "sumo2.png"
            
        default:
            return nil
        }
        
        return "https://images.whattomine.com/coins/logos/000/000/\(String(format:"%03d", id))/medium/\(suffix)"
    }
}

