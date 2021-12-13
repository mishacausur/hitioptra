//
//  FollowersTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class FollowersTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let postsCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = Font.setFont(.regular, 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = Font.setFont(.regular, 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followingsCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = Font.setFont(.regular, 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomLine: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.setColor(.darkViolet)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellWithData(profile: ProfileData) {
        postsCountLabel.text = "\(profile.postsCount) \nпубликаций"
        followersCountLabel.text = "\(profile.followers) \nподписчиков"
        followingsCountLabel.text = "\(profile.followings) \nподписок"
    }
    
    private func setupCell() {
        contentView.addSubviews(stackView, bottomLine)
        stackView.addArrangedSubview(postsCountLabel)
        stackView.addArrangedSubview(followersCountLabel)
        stackView.addArrangedSubview(followingsCountLabel)
        
        let width: CGFloat = (frame.width - 22 * 2 - 8 * 2) / 3
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        
            postsCountLabel.widthAnchor.constraint(equalToConstant: width),
            postsCountLabel.heightAnchor.constraint(equalToConstant: width),
        
            bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5),]
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
}
