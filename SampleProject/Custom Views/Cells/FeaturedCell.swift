//
//  HomeCollectionViewCell.swift
//  SampleProject
//
//  Created by Manish Tard on 28/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
    
    static let reuseId = "featuredCell"
    
    var taglineLabel = UILabel()
    var nameLabel = UILabel()
    var subHeadingLabel = UILabel()
    var imageView = UIImageView()
    var separator = UIView()
    
    var stackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configureUI()
        setConstraints()
    }
    
    
    func setValuesForCellElements(app: App){
        taglineLabel.text = app.tagline
        nameLabel.text  = app.name
        subHeadingLabel.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
    
    
    private func configureStackView(){
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureUI(){
        stackView.addArrangedSubview(separator)
        stackView.addArrangedSubview(taglineLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(subHeadingLabel)
        stackView.addArrangedSubview(imageView)
        
        taglineLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        taglineLabel.textColor = .systemBlue
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        nameLabel.textColor = .label
        
        subHeadingLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        subHeadingLabel.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        separator.backgroundColor = .quaternaryLabel
    }
    
    
    private func setConstraints(){
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        subHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: nameLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
