//
//  CryptoNewsViewController.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/13/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

import UIKit
import SafariServices

class CryptoNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    
    let newsURL = "https://newsapi.org/v2/everything?sources=crypto-coins-news&apiKey=fe79aa80ed7b49f5bdf68592100a2b96"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()

        getNews { (response, error) in
            if let error = error {
                print("Error fetching", error)
            }
            guard let article = response?.articles else { return }
            self.articles = article
            self.tableView.reloadData()
        }

    }
    
    func setupUI() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .luckyPointColor
        navigationController?.navigationBar.barTintColor = UIColor.black

        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    //MARK: My take on URLSession
    
    func getNews(completion: @escaping (CryptoNews? , Error?) -> ()) {
        
        guard let url = URL(string: newsURL) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error getting data", error)
                completion(nil, error)
            }
            //FIXME: UPDATE WITH RESPONSE CHECK
            guard let data = data else { return }
            
            do {
                let news = try JSONDecoder().decode(CryptoNews.self, from: data)
                
                DispatchQueue.main.async {
                    completion(news, nil)
                }
            } catch let jsonError {
                print("Error decoding data" , jsonError)
            }
        }
        task.resume()
    }
 
}

extension CryptoNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoNewsCell", for: indexPath) as? CryptoNewsCell else {
            
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.dataSource = self.articles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let newsURL = articles[indexPath.row].url,
            let newsURLforSafari = URL(string: newsURL)
            else {return}
        
        let safariVC = SFSafariViewController(url: newsURLforSafari)
        safariVC.delegate = self as? SFSafariViewControllerDelegate
        safariVC.preferredBarTintColor = UIColor.darkGray
        safariVC.preferredControlTintColor = UIColor.luckyPointColor
        self.present(safariVC, animated: true, completion:  nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
