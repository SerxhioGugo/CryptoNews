//
//  SearchResult.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 2/26/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let status: String
    let totalResults: Int
    let articles: [SearchArticle]
}

struct SearchArticle: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id, name: String
}
