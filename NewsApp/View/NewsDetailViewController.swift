//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//
import UIKit

class NewsDetailViewController: UIViewController {
    var viewModel: NewsDetailViewModel!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    private let publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    private let imageView = UIImageView()
    private let sourceButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        sourceButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(
            views: [
                publishedDateLabel,
                titleLabel,
                authorLabel,
                descriptionLabel,
                imageView,
                sourceButton
            ])
        
        labelsConfig()
        imgConfig()
        sourceButtonConfig()
    }
    
    private func labelsConfig(){
        NSLayoutConstraint.activate([
            
            publishedDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            publishedDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            publishedDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            titleLabel.leadingAnchor.constraint(equalTo: publishedDateLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: publishedDateLabel.bottomAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: publishedDateLabel.trailingAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
                        
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    private func imgConfig(){
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func sourceButtonConfig(){
        sourceButton.setTitle("Read full article", for: .normal)
        sourceButton.addTarget(self, action: #selector(openSource), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: viewModel.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )
        
        NSLayoutConstraint.activate([
            sourceButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            sourceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15)
        ])
        
    }
    private func bindViewModel() {
        titleLabel.text = viewModel.title
        publishedDateLabel.text = viewModel.publishedAt
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        imageView.image = viewModel.image
    }
    
    @objc private func openSource() {
        if let urlString = viewModel.sourceUrl {
            guard let url = URL(string: urlString) else {
                return
            }
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func toggleFavorite() {
        viewModel.toggleSelection()
        
        navigationItem.rightBarButtonItem?.image = viewModel.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
}

