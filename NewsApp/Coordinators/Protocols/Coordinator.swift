//
//  Coordinator.swift
//  NewsApp
//
//  Created by A Mairam on 8/10/24.
//

import UIKit

protocol Coordinator {    
    func start()
    func showNewsDetail(for article: NewsArticlePreview)
}
