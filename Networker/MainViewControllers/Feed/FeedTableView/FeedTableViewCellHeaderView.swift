//
//  FeedTableViewCellHeaderView.swift
//  Networker
//
//  Created by Misha Causur on 29.10.2021.
//

import Foundation
import UIKit

class FeedTableViewCellHeaderView: UIView {
    
    var isLiked: Bool
    
    var likes: Int
    
    let likeIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "DarkViolet")
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()

    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-Regular", size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, isLiked: Bool, likes: Int) {
        self.isLiked = isLiked
        self.likes = likes
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeTapped() {
        isLiked.toggle()
    }
    
    private func setupView() {
        self.addSubviews(likeIcon, likeLabel)
        let constraints = [
            likeIcon.topAnchor.constraint(equalTo: self.topAnchor),
            likeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            
            likeLabel.centerYAnchor.constraint(equalTo: likeIcon.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 4),
            likeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
