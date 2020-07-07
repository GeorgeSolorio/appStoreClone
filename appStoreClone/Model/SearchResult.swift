//
//  SearchResult.swift
//  appStoreClone
//
//  Created by George Solorio on 7/6/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
}
