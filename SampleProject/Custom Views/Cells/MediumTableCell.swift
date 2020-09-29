//
//  MediumTableCell.swift
//  SampleProject
//
//  Created by Manish Tard on 28/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import UIKit

class MediumTableCell: UICollectionViewCell {
    
    static let reuseId = "MediumCell"
    
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    let buyButton = UIButton()
    var outerStackView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    
    func setValuesFromModel(app: App){
        nameLabel.text = app.name
        subtitleLabel.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
    
    
    private func configureUI(){
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.textColor = .label
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        
        let innerStackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        innerStackView.axis = .vertical
        outerStackView = UIStackView(arrangedSubviews: [imageView,innerStackView,buyButton])
        outerStackView.axis = .horizontal
        outerStackView.alignment = .center
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(outerStackView)
    }
    
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        outerStackView.spacing = 5
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
