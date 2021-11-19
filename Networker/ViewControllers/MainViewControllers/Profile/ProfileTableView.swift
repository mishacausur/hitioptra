//
//  ProfileTableView.swift
//  Networker
//
//  Created by Misha Causur on 13.11.2021.
//

import Foundation
import UIKit

class ProfileTableView: UIView {
    
    private var user: ProfileData
    
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
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "Post")
        return tableView
    }()
    
    init(frame: CGRect, user: ProfileData) {
        self.user = user
        super.init(frame: frame)
        setupView()
//        configureRefreshControl()
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

extension ProfileTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: HeaderUserProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! HeaderUserProfileTableViewCell
            cell.configureProfile(profile: user)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell: FollowersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Followers", for: indexPath) as! FollowersTableViewCell
            cell.configureCellWithData(profile: ProfileData.mishutto)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Photos", for: indexPath) as! PhotosTableViewCell
            cell.configureCellWithData(profile: ProfileData.mishutto)
            return cell
        }
        
        return UITableViewCell()
    }
    

}
