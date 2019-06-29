//
//  SearchClient.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 2/26/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

class SearchClient {
    static let shared = SearchClient()
    
    func fetchNewsForTerm(searchTerm: String, completion: @escaping ([SearchArticle], Error?) -> Void) {
        print("Fetching News from SearchClient in progres...")
        
        let urlString = "https://newsapi.org/v2/top-headlines?q=\(searchTerm)&apiKey=fe79aa80ed7b49f5bdf68592100a2b96"
        
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch apps:", error)
                completion([], nil)
                return
            }
            guard let data = data else { return }
            
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.articles, nil)
            } catch let jsonErr{
                print("Failed to decode: ", jsonErr)
                completion([], jsonErr)
            }
        }.resume()
    }
}
