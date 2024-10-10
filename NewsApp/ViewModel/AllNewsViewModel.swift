//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit
import CoreData

class AllNewsViewModel: NewsListViewModelProtocol{
    var articles: [NewsArticle] = []
    var onDataLoaded: (() -> Void)?

    func loadNews() {
        Task{
            try await loadNewsFromAPI()
            DispatchQueue.main.async {
                self.onDataLoaded?()
            }
        }
    }
    
    func loadNewsFromAPI() async throws {
        do {
            let newsResponse = try await NetworkManager.shared.get(url: Constants.newsUrl) as NewsResponse
            self.articles = newsResponse.articles
            let favoriteArticles = CoreDataManager.shared.fetchFavoriteArticles()
            let favoriteTitles = Set(favoriteArticles.map { $0.id })
            
            for i in self.articles.indices {
                let article = articles[i]
                let isFavorite = favoriteTitles.contains(article.title)
                self.articles[i].isFavorite = isFavorite
            }
        } catch {
            print("Error \(error)")
        }
    }
}
