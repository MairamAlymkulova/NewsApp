//
//  AllNewViewController+Extention.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

extension AllNewsViewController: CustomTableViewDelegate{
    func didSelectArticle(article: NewsDetail) {
        coordinator?.showNewsDetail(for: article)
    }
}
