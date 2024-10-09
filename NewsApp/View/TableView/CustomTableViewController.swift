//
//  CustomTableView.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

class CustomTableView: UITableView {
    
    var viewModel: NewsViewModel!
    var articles: [NewsDetail] = []
    weak var customTableViewDelegate: CustomTableViewDelegate?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with viewModel: NewsViewModel){
        self.viewModel = viewModel
        self.articles = viewModel.articles
        self.reloadData()
    }
    
    func setup(){
        self.delegate = self
        self.dataSource = self
        self.estimatedRowHeight = 44 // Эстимированная высота
        self.rowHeight = UITableView.automaticDimension // Автоматическая высота

        self.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellID)
    }
}

