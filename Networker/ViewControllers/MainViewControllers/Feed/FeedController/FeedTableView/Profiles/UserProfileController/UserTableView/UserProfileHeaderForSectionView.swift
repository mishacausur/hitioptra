//
//  UserProfileHeaderForSectionView.swift
//  Networker
//
//  Created by Misha Causur on 03.11.2021.
//

import UIKit

class UserProfileHeaderForSectionView: UITableViewHeaderFooterView {

    let photosLabel: UILabel = {
        let label = UILabel()
        label.font = Font.setFont(.regular, 18)
        label.textColor = Color.setColor(.darkViolet)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photosCountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.setFont(.semibold, 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(count: Int) {
        photosLabel.text = "Публикации"
        photosCountLabel.text = "\(count)"
    }
    
    private func setupCell() {
        contentView.addSubviews(photosLabel, photosCountLabel)
        
        let constraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
        
            photosCountLabel.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            photosCountLabel.leadingAnchor.constraint(equalTo: photosLabel.trailingAnchor, constant: 8)]
        
        NSLayoutConstraint.activate(constraints)
    }

}
