//
//  UserPhotoCollectionViewCell.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "2")
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect){
           super.init(frame: frame)
           setupCell()
          
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    private func setupCell() {
        contentView.addSubviews(photoView)
        
        let constraints = [
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            photoView.widthAnchor.constraint(equalToConstant: 44),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
