//
//  UserPhotoCollectionView.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import UIKit

class UserPhotoCollectionView: UIView {
    
    var photos = [UIImage(named: "1"),UIImage(named: "6"),UIImage(named: "3"),UIImage(named: "2"),UIImage(named: "4"),UIImage(named: "5"), UIImage(named: "6")]
    
    private lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(UserPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubviews(photoCollection)
        
        let constraints = [
            photoCollection.topAnchor.constraint(equalTo: self.topAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: 150),
            photoCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension UserPhotoCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserPhotoCollectionViewCell = photoCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! UserPhotoCollectionViewCell
        cell.photoView.image = photos[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
       
       }
    
    
}
