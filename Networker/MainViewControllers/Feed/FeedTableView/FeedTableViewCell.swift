//
//  FeedTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 22.10.2021.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    var isLiked = Bool() {
        didSet {
            DispatchQueue.main.async {
                self.likeIcon.setImage(self.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
                if self.isLiked == false {
                    self.disliked?()
                } else {
                    self.liked?()
                }
            }
        }
    }
    
    var liked: (()->())?
    
    var disliked: (()->())?
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 18)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userType: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-Light", size: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-Regular", size: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-Regular", size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 4
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let likeIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "DarkViolet")
//        button.setImage(UIImage.init(systemName: "heart"), for: .normal)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeTapped() {
        isLiked.toggle()
    }
    
    private func setupCell() {
        contentView.addSubviews(userImage, userName, userType, dateLabel, postTextLabel, postImage, likeIcon, likeLabel)
        contentView.backgroundColor = .white
       
        let constraints = [
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),
        
            userName.topAnchor.constraint(equalTo: userImage.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 12),
            
            userType.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            userType.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
        
            dateLabel.topAnchor.constraint(equalTo: userType.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
        
            postTextLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 12),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
        
            postImage.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: postTextLabel.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: postTextLabel.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 184),
        
            likeIcon.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            likeIcon.leadingAnchor.constraint(equalTo: postImage.leadingAnchor, constant: 6),
        
            likeLabel.centerYAnchor.constraint(equalTo: likeIcon.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 4),
            likeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),]
        
        NSLayoutConstraint.activate(constraints)
    }
}
