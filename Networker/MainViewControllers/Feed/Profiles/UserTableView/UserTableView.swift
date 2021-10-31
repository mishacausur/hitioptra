//
//  UserTableView.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import UIKit

class UserTableView: UIView {
    
    var profile: ProfileData
    
    var photos: [UIImage] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeaderUserProfileTableViewCell.self, forCellReuseIdentifier: "Header")
        tableView.register(FollowersTableViewCell.self, forCellReuseIdentifier: "Followers")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "Photos")
        return tableView
    }()
    
    init(frame: CGRect, profile: ProfileData, photos: [UIImage]) {
        self.profile = profile
        self.photos = photos
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubviews(tableView)
        tableView.backgroundColor = .white
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),]
        
        NSLayoutConstraint.activate(constraints)
    }
}


extension UserTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: HeaderUserProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! HeaderUserProfileTableViewCell
            cell.configureCellWithData(profile: profile)
            return cell
        }
        if indexPath.row == 1 {
            let cell: FollowersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Followers", for: indexPath) as! FollowersTableViewCell
            cell.configureCellWithData(profile: profile)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Photos", for: indexPath) as! PhotosTableViewCell
            cell.configureCellWithData(profile: profile)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
