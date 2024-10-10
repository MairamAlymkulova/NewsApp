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
        articles.removeAll()
        do {
            let newsResponse = try await NetworkManager.shared.get(url: Constants.newsUrl) as NewsResponse
            self.articles = newsResponse.articles
            let favoriteArticles = CoreDataManager.shared.fetchFavoriteArticles()
            
            for i in self.articles.indices {
                let article = articles[i]
                self.articles[i].isFavorite = isArticleFavorite(article: article, favoriteArticles: favoriteArticles)
            }
        } catch {
            print("Error \(error)")
        }
    }
    
    func isArticleFavorite(article: NewsArticle, favoriteArticles: [News]) -> Bool {
        return favoriteArticles.contains { $0.title == article.title }
    }
    
    func updateArticle(at index: Int, with newsArticle: NewsArticle) {
        guard articles.indices.contains(index) else { return }
        articles[index] = newsArticle
    }

}
