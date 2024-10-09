//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by A Mairam on 8/10/24.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    let tabbar: UITabBarController
    
    init(window: UIWindow?) {
        self.window = window
        self.tabbar = MainTabBarController()
    }
    
    func start() {
        setupTabBar()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }
    
    private func setupTabBar(){
        let viewControllers: [UIViewController] = TabType.allCases.map { tab in
            return createNavigationControler(tab: tab)
        }
        tabbar.viewControllers = viewControllers
    }
    
    private func createNavigationControler(tab: TabType) -> UINavigationController{
        let navigationController = UINavigationController()
        let viewController: UIViewController
        
        switch tab {
        case .allNews:
            viewController = AllNewsViewController()
            if let allNewsVC = viewController as? AllNewsViewController {
                allNewsVC.coordinator = self
            }
        case .selectedNews:
            viewController = SelectedNewsViewController()
        }
        viewController.title = tab.title
        navigationController.navigationBar.tintColor = .label
        navigationController.viewControllers = [viewController]
        
        navigationController.tabBarItem = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.icon),
            tag: tab.rawValue
        )
        
        return navigationController
    }
    
    func showNewsDetail(for article: NewsArticlePreview){
        let detailViewController = NewsDetailViewController(article: article)
        if let selectedNC = tabbar.selectedViewController as? UINavigationController{
            selectedNC.pushViewController(detailViewController, animated: true)
        }
    }
}
