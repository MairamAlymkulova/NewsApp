//
//  FavouriteNewsViewModel.swift
//  NewsApp
//
//  Created by A Mairam on 11/10/24.
//

import Foundation

class FavouriteNewsViewModel: NewsListViewModelProtocol{
    var onDataLoaded: (() -> Void)?
    
    var articles: [NewsArticle] = []
    
    func loadNews() {
        
        let news = CoreDataManager.shared.fetchFavoriteArticles()
        
        for article in news {
            guard let title = article.title,
                  let content = article.content,
                  let publishedAt = article.publishedDate,
                  let author = article.author,
                  let description = article.newsDescription,
                  let urlToImage = article.urlToimage,
                  let sourceUrl = article.sourceUrl,
                  let source = article.source,
                  let sourceId = source.id,
                  let sourceName = source.name
            else {
                continue
            }
            let newsSource = NewsSource(
                id: sourceId,
                name: sourceName
            )
            let newsArticle = NewsArticle(
                source: newsSource,
                author: author,
                title: title,
                description: description,
                url: sourceUrl,
                urlToImage: urlToImage,
                publishedAt: publishedAt,
                content: content,
                isFavorite: true
            )
            
            self.articles.append(newsArticle)
        }
    }
    
}
