//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

class NewsDetailViewModel {
    private var news: NewsDetail
    
    var image: UIImage? {
        return news.image
    }
    var publishedAt: String {
        return news.publishedAt
    }
    var content: String {
        return news.content
    }

    var title: String {
        return news.title
    }
    var author: String {
        return news.author
    }
   
    var description: String {
        return news.description
    }
    var sourceUrl: String? {
        return news.sourceUrl
    }
    var isFavorite: Bool {
        get {
            return news.isFavorite
        }
        set {
            news.isFavorite = newValue
        }
    }
    
    init(news: NewsDetail) {
        self.news = news
    }
    
    func toggleSelection(){
        self.isFavorite.toggle()
    }
}
