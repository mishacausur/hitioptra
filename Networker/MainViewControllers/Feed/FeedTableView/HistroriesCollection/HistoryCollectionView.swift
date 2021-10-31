//
//  HistoryCollectionView.swift
//  Networker
//
//  Created by Misha Causur on 20.10.2021.
//

import UIKit


class HistoryCollectionView: UIView {
    
    var users: [UserProfile]
    
    private lazy var historyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.alpha = 1
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collection
    }()
    
    
    init(frame: CGRect, users: [UserProfile]) {
        self.users = users
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(historyCollection)

        historyCollection.backgroundColor = .clear
        [historyCollection.topAnchor.constraint(equalTo: self.topAnchor),
         historyCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         historyCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         historyCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
    }
}

extension HistoryCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = users.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HistoryCollectionViewCell = historyCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HistoryCollectionViewCell
        
        cell.user = users[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: 22, bottom: 16, right: .zero)
       
       }
    
}
