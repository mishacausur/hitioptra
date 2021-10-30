//
//  SkeletonView.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import SkeletonView

class SkeletonView: UIView {
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.isSkeletonable = true
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userType: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTextLabel1: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTextLabel2: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTextLabel3: UILabel = {
        let label = UILabel()
        label.text = " "
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeFromSuperview()
    }
    
    private func setupView() {
        self.addSubviews(userImage, userName, userType, dateLabel, postTextLabel, postTextLabel1, postTextLabel2, postTextLabel3)
        
        let constraints = [
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),
        
            userName.topAnchor.constraint(equalTo: userImage.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 12),
            userName.widthAnchor.constraint(equalToConstant: 220),
            
            userType.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            userType.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userType.widthAnchor.constraint(equalToConstant: 220),
        
            dateLabel.topAnchor.constraint(equalTo: userType.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 220),
        
            postTextLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 12),
            postTextLabel.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            postTextLabel.widthAnchor.constraint(equalToConstant: 460),
        
            postTextLabel1.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 8),
            postTextLabel1.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            postTextLabel1.widthAnchor.constraint(equalToConstant: 460),
        
            postTextLabel2.topAnchor.constraint(equalTo: postTextLabel1.bottomAnchor, constant: 8),
            postTextLabel2.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            postTextLabel2.widthAnchor.constraint(equalToConstant: 460),
        
            postTextLabel3.topAnchor.constraint(equalTo: postTextLabel2.bottomAnchor, constant: 8),
            postTextLabel3.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            postTextLabel3.widthAnchor.constraint(equalToConstant: 460),]
        
        NSLayoutConstraint.activate(constraints)
    }
}
