//
//  PhotosTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    let photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-Regular", size: 18)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photosCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(systemName: "arrow.right.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "DarkViolet")
//        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return button
    }()
    
    let bottomLine: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DarkViolet")
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
            photosLabel.text = "Фотографии"
            photosCountLabel.text = "\(profile.photos)"
            configurePhotoCollection()
    }
    
    private func configurePhotoCollection() {
        let photoCollection: UserPhotoCollectionView = {
            let collection = UserPhotoCollectionView(frame: .zero)
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
        
        contentView.addSubviews(photoCollection)
        
        [photoCollection.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 8),
         photoCollection.leadingAnchor.constraint(equalTo: photosLabel.leadingAnchor),
         photoCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         photoCollection.heightAnchor.constraint(equalToConstant: 120),
         photoCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)].forEach { $0.isActive = true }
    }
    
    private func setupCell() {
        contentView.addSubviews(photosLabel, photosCountLabel, moreIcon, bottomLine)
        
        let constraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
        
            photosCountLabel.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            photosCountLabel.leadingAnchor.constraint(equalTo: photosLabel.trailingAnchor, constant: 8),
        
            moreIcon.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            moreIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
          
            bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5),]
        
        NSLayoutConstraint.activate(constraints)
    }

}
