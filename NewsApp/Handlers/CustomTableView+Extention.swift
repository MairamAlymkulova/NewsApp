//
//  CustomTableView+Extention.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

extension CustomTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.cellID,
            for: indexPath
        ) as? CustomTableViewCell else{
            return UITableViewCell()
        }
        let article = articles[indexPath.row]
        
        cell.configure(articleViewModel: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        customTableViewDelegate?.didSelectArticle(article: selectedArticle)
    }
}
