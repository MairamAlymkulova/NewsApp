//
//  CustomTableViewCell.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let cellID = "cellID"
    var viewModel: NewsDetailViewModel!
    
    private var previwImg: UIImageView = {
        let image = UIImageView()
        image.image = nil
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .label
        title.numberOfLines = 0
        return title
    }()
    
    private var articleDescription: UILabel = {
        let description = UILabel()
        
        description.font = UIFont.systemFont(ofSize: 13)
        description.textColor = .secondaryLabel
        description.numberOfLines = 0
        
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        backgroundColor = .secondarySystemBackground
        addSubviews(views: [previwImg, title, articleDescription])
        
        previewImgSetup()
        titleSetup()
        descriptionSetup()
    }
    private func previewImgSetup(){
        previwImg.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previwImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            previwImg.centerYAnchor.constraint(equalTo: centerYAnchor),
            previwImg.widthAnchor.constraint(equalToConstant: 100),
            previwImg.heightAnchor.constraint(equalTo: previwImg.widthAnchor, multiplier: 0.75)

        ])
    }
    private func titleSetup(){
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: previwImg.trailingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
    }
    
    private func descriptionSetup(){
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            articleDescription.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            articleDescription.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            articleDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            
        ])
    }

    func configure(article: NewsArticle){
        
        self.title.text = article.title
        self.articleDescription.text = article.description
        self.previwImg.image = nil
        if let image = viewModel.image {
            previwImg.image = image
        }
        else{
            viewModel.OnImageLoaded = { [weak self] in
                DispatchQueue.main.async {
                    self?.previwImg.image = self?.viewModel.image
                }
            }
        }
        
//        Task{
//            let data = try await NetworkManager.shared.getData(url: article.urlToImage)
//            self.previwImg.image = UIImage(data: data)
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
