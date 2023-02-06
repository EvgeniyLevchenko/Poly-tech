//
//  BookCollectionViewCell.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell , SelfConfiguring {
    
    static var reuseID: String = "BookCell"
    private let bookImageView = UIImageView(contentMode: .scaleAspectFit, backgroundColor: .systemGray5)
    private let activityIndicatorView = UIActivityIndicatorView()
    private let bookNameLabel = UILabel(text: "", font: .avenirMedium18(), numberOfLines: 0)
    private let authorNameLabel = UILabel(text: "", font: .avenir16(), numberOfLines: 0)
    private let descriptionLabel = UILabel(text: "", font: .avenir16(), numberOfLines: 0)
    private let publisherLabel = UILabel(text: "", font: .avenir14(), numberOfLines: 0)
    private let buyButton = UIButton(title: "Buy", titleColor: .white, backgroundColor: .systemBlue)
    private var buyURL = ""
    
    weak var delegate: RouterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        addBuyButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        self.layer.cornerRadius = 20.0
    }
    
    private func addBuyButtonAction() {
        buyButton.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
    }
    
    @objc private func showWebView() {
        delegate?.routeToWebView(with: buyURL)
    }
    
    func configure<T>(with value: T) where T : Hashable {
        guard let book: Book = value as? Book else { return }
        bookNameLabel.text = book.name
        authorNameLabel.text = book.author
        descriptionLabel.text = book.description
        publisherLabel.text = book.publisher
        fetchImage(with: book.imageURL)
        buyURL = book.buyURL
    }
    
    private func fetchImage(with url: String) {
        let imageURL = URL(string: url)
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else {
                return
            }
            
            DispatchQueue.main.async {
                self.bookImageView.image = UIImage(data: imageData)
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
    }
}

// MARK: - Setup Constraints
extension BookCollectionViewCell {
    private func setupConstraints() {
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [bookNameLabel, authorNameLabel, publisherLabel, buyButton], axis: .vertical, spacing: 12)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bookImageView)
        addSubview(activityIndicatorView)
        addSubview(stackView)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: self.topAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bookImageView.heightAnchor.constraint(equalToConstant: 240),
            bookImageView.widthAnchor.constraint(equalToConstant: 240 * 0.66)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: bookImageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
}
