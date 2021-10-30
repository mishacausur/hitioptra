//
//  HeaderUserProfileTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class HeaderUserProfileTableViewCell: UITableViewCell {
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 18)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let userType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-Light", size: 14)
        label.textColor = UIColor(named: "placeHolderColor")
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
        contentView.addSubviews(userImage, userName, userType)
        
        let constraints = [
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor),
        
            userName.topAnchor.constraint(equalTo: userImage.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 12),
        
            userType.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userType.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6)]
        
        NSLayoutConstraint.activate(constraints)
    }

}
