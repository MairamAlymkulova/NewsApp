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
            return favoriteArticles.filter { $0.isFavourite == true } // Фильтруем только избранные
        } catch {
            print("Ошибка при получении избранных статей  \(error.localizedDescription)")
            return []
        }
    }
}
