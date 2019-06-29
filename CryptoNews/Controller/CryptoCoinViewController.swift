//
//  CryptoCoinViewController.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/13/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

//

import UIKit
import Alamofire

class CryptoCoinViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let coinURL = "https://api.coinmarketcap.com/v1/ticker/?limit=100"
    var coins: [CoinResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
        
        getCoins { (response) in
            self.coins = response
            self.tableView.reloadData()
        }
        
    }
    
    func setupUI() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .luckyPointColor
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    
    
    //TODO: Use Alamofire for this request
    
    func getCoins(completion: @escaping ([CoinResponse]) -> ()) {
        Alamofire.request(coinURL, method: .get).responseJSON { (response) in
            
            var coins: [CoinResponse] = []
            
            guard let response = response.result.value as? [[String:Any?]] else {
                completion([])
                return
            }
            
            for dictionary in response {
                guard
                    let name = dictionary["name"] as? String,
                    let symbol = dictionary["symbol"] as? String,
                    let rank = dictionary["rank"] as? String,
                    let priceUsd = dictionary["price_usd"] as? String,
                    let lastUpdated = dictionary["last_updated"] as? String,
                    let percentChange24H = dictionary["percent_change_24h"] as? String,
                    let marketCap = dictionary["market_cap_usd"] as? String,
                    let availableSupply = dictionary["available_supply"] as? String,
                    let percentChange1h = dictionary["percent_change_1h"] as? String,
                    let percentChange7d = dictionary["percent_change_7d"] as? String
                    else { continue }
                
                let coinResponse = CoinResponse(name: name, symbol: symbol, rank: rank, price_usd: priceUsd, last_updated: lastUpdated, percent_change_24h: percentChange24H, market_cap_usd: marketCap, available_supply: availableSupply, percent_change_1h: percentChange1h, percent_change_7d: percentChange7d)
                
                coins.append(coinResponse)
            }
            completion(coins)
        }
    }
    
}

extension CryptoCoinViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCoinsCell", for: indexPath) as? CryptoCoinsCell else { return UITableViewCell() }
        
        cell.backgroundColor = UIColor.luckyPointColor
        cell.selectionStyle = .none
        
        let coin = coins[indexPath.row]
        
        cell.coinLabel.text = coin.symbol
        cell.rankLabel.text = "#\(coin.rank)"
        cell.priceLabel.text = "$\(coin.price_usd)"
        cell.pastDayLabel.text = "Past Day: (\(coin.percent_change_24h)%)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
}
