//
//  FeedTableViewCell.swift
//  Networker
//
//  Created by Misha Causur on 22.10.2021.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCell() {
        
    }
}
