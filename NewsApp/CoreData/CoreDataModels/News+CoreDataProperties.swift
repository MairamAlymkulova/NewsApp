//
//  News+CoreDataProperties.swift
//  NewsApp
//
//  Created by A Mairam on 11/10/24.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var urlToimage: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var newsDescription: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var sourceUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var source: Source?

}

extension News : Identifiable {

}
