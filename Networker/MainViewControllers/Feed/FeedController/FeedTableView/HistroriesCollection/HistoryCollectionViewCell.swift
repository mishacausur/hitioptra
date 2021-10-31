//
//  HistoryCollectionViewCell.swift
//  Networker
//
//  Created by Misha Causur on 20.10.2021.
//

import UIKit
import SkeletonView

class HistoryCollectionViewCell: UICollectionViewCell {
    
    var user: UserProfile? {
        didSet {
            DispatchQueue.main.async {
                self.userImage.image = self.user?.image
            }
        }
    }
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(userImage)
        
        let constraints = [
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
