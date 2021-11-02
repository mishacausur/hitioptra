//
//  FeedTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 22.10.2021.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM"
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var completion: (()->())?
    
    var tapped: (()->())?

    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 18)
        label.textColor = UIColor(named: "DarkViolet")
        label.isUserInteractionEnabled = true
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
    
    let footer: FeedTableViewCellFooterView = {
        let view = FeedTableViewCellFooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tappedToProfile() {
        tapped?()
    }
    
    func configureCellWithData(post: Post) {
        
        postTextLabel.text = post.text
        userName.text = post.author
        userType.text = post.type
        postImage.image = post.image
        footer.likeLabel.text = "\(post.likes)"
        footer.likeIcon.setImage(post.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        footer.commentLabel.text = "\(post.comments)"
        let date = Date(timeIntervalSince1970: TimeInterval(post.date))
        dateLabel.text = dateFormatter.string(from: date) + " в " + timeFormatter.string(from: date)
        let autor = post.author
        switch autor {
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
        contentView.addSubviews(userImage, userName, userType, dateLabel, postTextLabel, postImage, footer)
      
        contentView.backgroundColor = .white
        
        footer.completion = {
            self.completion?()
        }
        
        let imageTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedToProfile))
        let nameTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedToProfile))

        userImage.addGestureRecognizer(imageTappedRecognizer)
        userName.addGestureRecognizer(nameTappedRecognizer)
        
        
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
            postImage.heightAnchor.constraint(equalToConstant: 200),
            
            footer.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            footer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
