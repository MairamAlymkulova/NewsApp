//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

class NewsViewModel{
    var articles: [NewsDetail] = []

    func loadNews() async throws{
        do{
            let newsResponse = try await NetworkManager.shared.get(url: Constants.newsUrl) as NewsResponse
            for article in newsResponse.articles {
                let image = await loadImage(from: article.urlToImage)
                
                let newArticle = NewsDetail(
                    author: article.author,
                    title: article.title,
                    description: article.description,
                    image: image,
                    publishedAt: article.publishedAt,
                    content: article.content,
                    sourceUrl: article.url,
                    isFavorite: false
                )
                
                self.articles.append(newArticle)
            }
        }
        catch {
            print("Error \(error)")
        }
    }
    
    func loadImage(from url: String) async -> UIImage? {
        do{
            let data = try await NetworkManager.shared.getData(url: url)
            return UIImage(data: data)
        }
        catch{
            print("Error \(error)")
            return nil
        }
    }
}
