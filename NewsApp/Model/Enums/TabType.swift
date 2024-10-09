//
//  TabType.swift
//  NewsApp
//
//  Created by A Mairam on 8/10/24.
//

import Foundation

enum TabType: Int, CaseIterable{
    case allNews
    case selectedNews
    
    var title: String {
        switch self{
        case .allNews:
            "All News"
        case .selectedNews:
            "Selected"
        }
    }
    
    var icon: String {
        switch self{
        case .allNews:
            "newspaper.fill"
        case .selectedNews:
            "bookmark.fill"
        }
    }
}
