//
//  CustomerReviews.swift
//  appStoreClone
//
//  Created by George Solorio on 7/11/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let title: Label
    let content: Label
    let author: Author
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}
