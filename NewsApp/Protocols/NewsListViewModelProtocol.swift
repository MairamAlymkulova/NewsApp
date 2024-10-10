//
//  NewsListViewModelProtocol.swift
//  NewsApp
//
//  Created by A Mairam on 10/10/24.
//

import Foundation

protocol NewsListViewModelProtocol{
    var articles: [NewsArticle] { get }
    var onDataLoaded: (() -> Void)? {get set}
    func loadNews()
    func updateArticle(at index: Int, with newsArticle: NewsArticle)
}
