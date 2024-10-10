//
//  ШьфпуДщфвук.swift
//  NewsApp
//
//  Created by A Mairam on 10/10/24.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: NSString(string: url)) {
            completion(cachedImage)
            return
        }
        
        Task {
            do {
                let data = try await NetworkManager.shared.getData(url: url)
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: NSString(string: url))
                    completion(image)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error loading image: \(error)")
                completion(nil)
            }
        }
    }
}
