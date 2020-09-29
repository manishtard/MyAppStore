//
//  SectionHeader.swift
//  SampleProject
//
//  Created by Manish Tard on 28/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    let title = UILabel()
    let subtitle = UILabel()
    let seprator = UIView()
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    
    private func configureUI(){
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        title.textColor = .label
        subtitle.textColor = .secondaryLabel
        seprator.backgroundColor = .tertiaryLabel
        
        stackView = UIStackView(arrangedSubviews: [seprator, title, subtitle])
        stackView.axis = .vertical
        addSubview(stackView)
    }
    
    
    private func setConstraints(){
        seprator.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seprator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        stackView.setCustomSpacing(10, after: seprator)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
