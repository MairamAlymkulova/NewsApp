//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by A Mairam on 10/10/24.
//

import Foundation

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchFavoriteArticles() -> [News] {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            let favoriteArticles = try context.fetch(fetchRequest)
            return favoriteArticles.filter { $0.isFavourite == true }
        } catch {
            print("Ошибка при получении избранных статей  \(error.localizedDescription)")
            return []
        }
    }
    
    func saveFavoriteArticle(news: NewsArticle) {
        let context = CoreDataManager.shared.context
        let favoriteArticle = News(context: context)
        if favoriteArticle.source == nil {
            favoriteArticle.source = Source(context: context)
        }
        favoriteArticle.source?.id = news.source.id
        favoriteArticle.source?.name = news.source.name
        favoriteArticle.title = news.title
        favoriteArticle.content = news.content
        favoriteArticle.publishedDate = news.publishedAt
        favoriteArticle.urlToimage = news.urlToImage
        favoriteArticle.author = news.author
        favoriteArticle.newsDescription = news.description
        favoriteArticle.sourceUrl = news.url
        favoriteArticle.isFavourite = news.isFavorite ?? true
        
        
        do {
            try context.save()
            print("Статья сохранена в избранное.")
        } catch {
            print("Ошибка при сохранении статьи: \(error.localizedDescription)")
        }
    }
    
    func removeFavoriteArticle(news: NewsArticle) {
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
}
