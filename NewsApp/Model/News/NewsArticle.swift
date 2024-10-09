//
//  NewsArticle.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

struct NewsArticle: Codable {
    let source: NewsSource
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
}
