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
                try await viewModel.loadNews()
                DispatchQueue.main.async {
                                    self.activityIndicator.stopAnimating()
                                    self.tableView.config(with: self.viewModel)
                                }
            } catch {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showError(error) // Показать ошибку пользователю
                }
            }
        }
        
    }
    
    private func showError(_ error: Error){
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        present(
            alert,
            animated: true,
            completion: nil)
        
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

