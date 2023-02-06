//
//  CategoryCollectionViewCell.swift
//  Poly-tech test
//
//  Created by QwertY on 03.02.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, SelfConfiguring {
    
    static var reuseID: String = "CategoryCell"
    private let categoryNameLabel = UILabel(text: "", font: .avenirMedium18(), numberOfLines: 2)
    private let publishedDate = UILabel(text: "", font: .avenir16())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 20.0
    }
    
    func configure<T>(with value: T) where T : Hashable {
        guard let category: Category = value as? Category else { return }
        categoryNameLabel.text = category.categoryName
        publishedDate.text = category.publishedDate
    }
}

// MARK: - Setup Constraints
extension CategoryCollectionViewCell {
    private func setupConstraints() {
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDate.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(categoryNameLabel)
        addSubview(publishedDate)
        
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            categoryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            publishedDate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            publishedDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            publishedDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}
