//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit
import CoreData

class NewsDetailViewModel {
    var news: NewsArticle
    
    var onStateChanged: (() -> Void)?
    
    var OnImageLoaded: (() -> Void)?
    
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
        return news.url
    }
    var isFavorite: Bool? {
        get {
            
            return news.isFavorite
        }
        set {
            news.isFavorite = newValue
        }
    }
    private var image_: UIImage?
    
    var image: UIImage? {
        get {
            return image_
        }
        set {
            image_ = newValue
        }
    }
    
    init(news: NewsArticle) {
        self.news = news
        self.loadImage()
    }
    
    func toggleSelection(){
        self.isFavorite?.toggle()

        if self.isFavorite == true {
            saveFavoriteArticle()
        }
        else{
            removeFavoriteArticle()
        }
        self.onStateChanged?()
    }
    
    private func saveFavoriteArticle() {
        CoreDataManager.shared.saveFavoriteArticle(news: self.news)
    }
    
    private func removeFavoriteArticle() {
        CoreDataManager.shared.removeFavoriteArticle(news: self.news)
    }
    
    private func loadImage(){
        Task{
            ImageLoader.shared.loadImage(from: news.urlToImage) { [weak self] loadedImage in
                self?.image_ = loadedImage
                self?.OnImageLoaded?()
            }
        }
    }
}
