//
//  CustomTableView.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    var viewModel: NewsListViewModelProtocol!
    var coordinator: AppCoordinator!
    private let activityIndicator = UIActivityIndicatorView()
    var detailViewModel: NewsDetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onDataLoaded = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.loadNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        setup()
    }
    
    func setup(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.cellID,
            for: indexPath
        ) as? CustomTableViewCell else{
            return UITableViewCell()
        }
        let article = viewModel.articles[indexPath.row]
        cell.viewModel = NewsDetailViewModel(news: article)
        cell.configure(article: article)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedArticle = viewModel.articles[indexPath.row]
        self.detailViewModel = NewsDetailViewModel(news: selectedArticle)

//        self.detailViewModel?.onStateChanged = { [weak self] in
//            DispatchQueue.main.async {
//                self?.viewModel.loadNews()
//                self?.tableView.reloadData()
//            }
//        }

        coordinator.showNewsDetail(for: selectedArticle)
    }
}

