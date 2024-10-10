//
//  ШьфпуДщфвук.swift
//  NewsApp
//
//  Created by A Mairam on 10/10/24.
//

import UIKit

class ImageLoader {
    static var shared = ImageLoader()
    
    private init() {}
    
    func loadImage(from url: String, completion: @escaping(UIImage?) -> Void) {
        Task{
            do{
                let data = try await NetworkManager.shared.getData(url: url)
                let image = UIImage(data: data)
                completion(image)
            }
            catch{
                print("Error \(error)")
                completion (nil)
            }
        }
    }
}
