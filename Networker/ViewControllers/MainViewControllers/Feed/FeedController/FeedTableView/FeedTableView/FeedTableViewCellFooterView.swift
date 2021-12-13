//
//  FeedTableViewCellFooterView.swift
//  Networker
//
//  Created by Misha Causur on 29.10.2021.
//

import Foundation
import UIKit

class FeedTableViewCellFooterView: UIView {
    
    var completion: (()->())?
    
    let likeIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Color.setColor(.darkViolet)
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
    
    let commentIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Color.setColor(.darkViolet)
        button.setImage(UIImage.init(systemName: "bubble.right"), for: .normal)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()

    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-Regular", size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let saveIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Color.setColor(.darkViolet)
        button.setImage(UIImage.init(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeTapped() {
        completion?()
    }
    
    @objc private func commentTapped() {
        
    }
    
    private func setupView() {
        self.addSubviews(likeIcon, likeLabel, commentIcon, commentLabel, saveIcon)
        let constraints = [
            likeIcon.topAnchor.constraint(equalTo: self.topAnchor),
            likeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            
            likeLabel.centerYAnchor.constraint(equalTo: likeIcon.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 4),
            likeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            commentIcon.centerYAnchor.constraint(equalTo: likeIcon.centerYAnchor),
            commentIcon.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 14),
        
            commentLabel.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 4),
            commentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            saveIcon.centerYAnchor.constraint(equalTo: commentIcon.centerYAnchor),
            saveIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
