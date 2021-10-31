//
//  FeedHeaderView.swift
//  Networker
//
//  Created by Misha Causur on 24.10.2021.
//

import UIKit

class FeedHeaderView: UITableViewHeaderFooterView {
    
    var users: [UserProfile]? {
        didSet {
            guard let users = users else { return }
            DispatchQueue.main.async {
                self.setupCell(users: users)
            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(users: [UserProfile]) {
        let historyCollection = HistoryCollectionView(frame: .zero, users: users)
        historyCollection.translatesAutoresizingMaskIntoConstraints = false
        historyCollection.startAnimation()
        contentView.addSubview(historyCollection)
        
        let constraints = [
            historyCollection.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            historyCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            historyCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            historyCollection.heightAnchor.constraint(equalToConstant: 50),
            historyCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }

}
