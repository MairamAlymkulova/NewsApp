//
//  MainTabBarController.swift
//  NewsApp
//
//  Created by A Mairam on 8/10/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.isTranslucent = false
    }

}
