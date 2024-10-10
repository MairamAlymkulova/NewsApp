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
    var isFavorite: Bool {
        get {
            
            return news.isFavorite ?? false
        }
        set {
            news.isFavorite = newValue
            if newValue {
                saveFavoriteArticle()
            }
            else{
                removeFavoriteArticle()
            }
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
        self.isFavorite.toggle()
    }
    
    private func saveFavoriteArticle() {
        let context = CoreDataManager.shared.context
        let favoriteArticle = News(context: context)
        
        favoriteArticle.title = news.title
        favoriteArticle.content = news.content
        favoriteArticle.publishedDate = news.publishedAt
        favoriteArticle.urlToimage = news.urlToImage
        favoriteArticle.author = news.author
        favoriteArticle.newsDescription = news.description
        favoriteArticle.sourceUrl = news.url
        favoriteArticle.isFavourite = true
        
        
        do {
            try context.save()
            print("Статья сохранена в избранное.")
        } catch {
            print("Ошибка при сохранении статьи: \(error.localizedDescription)")
        }
    }
    
    private func removeFavoriteArticle() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", news.title)
        
        do {
            let results = try context.fetch(fetchRequest)
            for article in results {
                context.delete(article)
            }
            try context.save()
            print("Статья удалена из избранного")
        } catch {
            print("Ошибка при удалении статьи: \(error.localizedDescription)")
        }
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
