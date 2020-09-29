//
//  SmallTableCell.swift
//  SampleProject
//
//  Created by Manish Tard on 29/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import UIKit

class SmallTableCell: UICollectionViewCell {
    
    static let resueId = "SmallTableCell"
    
    let nameLabel = UILabel()
    let imageView = UIImageView()
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    
    func setValuesFromModel(app: App){
        nameLabel.text = app.name
        imageView.image = UIImage(named: app.image)
    }
    
    
    private func configureUI(){
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        nameLabel.textColor = .label
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        contentView.addSubview(stackView)
    }
    
    
    private func setConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        stackView.setCustomSpacing(20, after: imageView)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
