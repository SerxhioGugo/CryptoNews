//
//  CryptoNewsCell.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/15/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

import UIKit

class CryptoNewsCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var dataSource: Any? {
        didSet {
            guard
                let article = dataSource as? Article,
                let newsImage = article.urlToImage,
                let newsImageURL = URL(string: newsImage)
                else { return }
            titleLabel.text = article.title ?? "No Title Provided"
            ImageService.getImage(withURL: newsImageURL) { (image) in
                self.newsImageView.image = image
            }
        }
    }


}
