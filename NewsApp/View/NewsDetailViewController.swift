//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

class NewsDetailViewController: UIViewController {

    let article: NewsArticlePreview
    
    init(article: NewsArticlePreview) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }

}
