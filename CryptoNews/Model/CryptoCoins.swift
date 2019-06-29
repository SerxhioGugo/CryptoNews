//
//  CryptoCoins.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/13/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

import Foundation


class CoinResponse {
    let name: String
    let symbol: String
    let rank: String
    let price_usd: String
    let last_updated: String
    let percent_change_24h: String
    let market_cap_usd: String
    let available_supply: String
    let percent_change_1h: String
    let percent_change_7d: String
    
    init(name: String, symbol: String, rank: String, price_usd: String, last_updated: String, percent_change_24h: String, market_cap_usd: String, available_supply: String, percent_change_1h: String, percent_change_7d: String) {
        
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price_usd = price_usd
        self.last_updated = last_updated
        self.percent_change_24h = percent_change_24h
        self.market_cap_usd = market_cap_usd
        self.available_supply = available_supply
        self.percent_change_1h = percent_change_1h
        self.percent_change_7d = percent_change_7d
    }
}
