//
//  CryptoNews.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/13/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

import Foundation

struct CryptoNews: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable {
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

