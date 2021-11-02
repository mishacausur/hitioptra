//
//  HeaderUserProfileTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class HeaderUserProfileTableViewCell: UITableViewCell {
    
    let topLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DarkViolet")
        return view
    }()
    
    let bottomLine: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DarkViolet")
        return view
    }()
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 22)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let userType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-Regular", size: 14)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(systemName: "info.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "DarkViolet")
//        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "Подробная информация"
        label.font = UIFont(name: "VenrynSans-Regular", size: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let messageButton: UIButton = {
        let button = UIButton()
//        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .bordered()
        var attributedString = AttributedString.init(stringLiteral: "Написать сообщение")
        attributedString.font = UIFont(name: "VenrynSans-Regular", size: 18)
        button.configuration?.attributedTitle = attributedString
        button.configuration?.buttonSize = .medium
        button.configuration?.baseBackgroundColor = UIColor(named: "DarkViolet")
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellWithData(profile: ProfileData) {
        let name = profile.name
        
        userName.text = name
        userType.text = profile.type
        switch name {
        case "Cosmo":
           userImage.image = UIImage(named: "cosmo")
        case "Science and Facts":
            userImage.image = UIImage(named: "science")
        case "Homo Sapiens":
            userImage.image = UIImage(named: "person")
        default:
            break
        }
        
    }
    
    private func setupCell() {
        contentView.addSubviews(topLine, userImage, userName, userType, moreIcon, moreLabel, messageButton, bottomLine)
//        contentView.backgroundColor = UIColor.init(named: "BackgroundViolet")
        let constraints = [
            topLine.topAnchor.constraint(equalTo: contentView.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            topLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            topLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),
        
            userName.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 4),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20),
        
            userType.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userType.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6),
        
            moreIcon.topAnchor.constraint(equalTo: userType.bottomAnchor, constant: 10),
            moreIcon.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
        
            moreLabel.centerYAnchor.constraint(equalTo: moreIcon.centerYAnchor),
            moreLabel.leadingAnchor.constraint(equalTo: moreIcon.trailingAnchor, constant: 6),
        
            messageButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 12),
            messageButton.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            messageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            messageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22),
            
            bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
