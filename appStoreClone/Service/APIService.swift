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
        //let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"

        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/10/explicit.json"
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
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/10/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
        
    // Helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }

            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
