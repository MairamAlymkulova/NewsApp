//
//  ViewController.swift
//  NewsApp
//
//  Created by A Mairam on 8/10/24.
//

import UIKit

class AllNewsViewController: UIViewController {
    private let viewModel = NewsViewModel()
    private let tableView = CustomTableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .red
        view.addSubviews(views: [
            activityIndicator,
            tableView
        ])
        
        tableViewConfig()
        activityIndicatorCofig()
        setup()
        
    }
    private func activityIndicatorCofig(){
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
    }
    private func setup (){
        
        activityIndicator.startAnimating()
        Task {
            do{
                await viewModel.loadNews()
                tableView.config(with: self.viewModel)
            }
            activityIndicator.stopAnimating()
        }
        
    }
    
    private func tableViewConfig(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.customTableViewDelegate = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

