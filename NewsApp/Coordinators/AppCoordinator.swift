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
        let viewController: UIViewController = NewsListTableViewController()
        
        if let vc = viewController as? NewsListTableViewController {
            vc.coordinator = self
            switch tab {
            case .allNews:
                vc.viewModel = AllNewsViewModel()
                
            case .selectedNews:
                vc.viewModel = FavouriteNewsViewModel()
            }
        }
        
        viewController.title = tab.title
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .label
        navigationController.viewControllers = [viewController]
        
        navigationController.tabBarItem = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.icon),
            tag: tab.rawValue
        )
        
        return navigationController
    }
    
    func showNewsDetail(for article: NewsArticle){
        let viewModel = NewsDetailViewModel(news: article)
        let detailViewController = NewsDetailViewController()
        detailViewController.viewModel = viewModel
        if let selectedNC = tabbar.selectedViewController as? UINavigationController{
            selectedNC.pushViewController(detailViewController, animated: true)
        }
    }
}
