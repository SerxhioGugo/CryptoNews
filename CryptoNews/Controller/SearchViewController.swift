//
//  SearchViewController.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/15/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var searchResult = [SearchArticle]()
    var timer: Timer?
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🔍 Search for news above..."
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Bold", size: 30)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.luckyPointColor
        return label
    }()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.luckyPointColor
        setupSearchBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .luckyPointColor
        
        view.addSubview(enterSearchTermLabel)
        NSLayoutConstraint.activate([
            enterSearchTermLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterSearchTermLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            enterSearchTermLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            enterSearchTermLabel.heightAnchor.constraint(equalToConstant: view.frame.height)
            ])
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { (_) in
            
            SearchClient.shared.fetchNewsForTerm(searchTerm: searchText) { (res, err) in
                if let err = err {
                    print("Error", err)
                    return
                }                
                self.searchResult = res
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.keyboardAppearance = .dark
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = searchResult.count != 0
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let search = searchResult[indexPath.row]
        cell.title.text = search.title
        cell.desc.text = search.description
        cell.newsImage.clipsToBounds = true
        cell.newsImage.layer.cornerRadius = 8
        cell.newsImage.layer.masksToBounds = true
        cell.backgroundColor = UIColor.luckyPointColor
        ImageService.getImage(withURL: URL(string: search.urlToImage)!) { (image) in
            cell.newsImage.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsURL = searchResult[indexPath.row].url
            guard let newsURLforSafari = URL(string: newsURL)
            else {return}
        
        let safariVC = SFSafariViewController(url: newsURLforSafari)
        safariVC.delegate = self as? SFSafariViewControllerDelegate
        safariVC.preferredBarTintColor = UIColor.darkGray
        safariVC.preferredControlTintColor = UIColor.luckyPointColor
        self.present(safariVC, animated: true, completion:  nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
