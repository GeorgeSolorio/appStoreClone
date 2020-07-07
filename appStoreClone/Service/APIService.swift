//
//  APIService.swift
//  appStoreClone
//
//  Created by George Solorio on 7/6/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() //Singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"

        guard let url = URL(string: urlString) else { return }

        // fetch data from internet
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion([], error)
                return
            }

            guard let data = data else { return }

            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
            } catch let jsonError {
                completion([], jsonError)
            }

        }.resume()
    }
}
