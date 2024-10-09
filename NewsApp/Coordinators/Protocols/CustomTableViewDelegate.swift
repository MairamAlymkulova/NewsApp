//
//  CustomTableViewDelegate.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

protocol CustomTableViewDelegate: AnyObject{
    func didSelectArticle(article: NewsDetail)
}


