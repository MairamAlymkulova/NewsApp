//
//  NewsResponse.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}
