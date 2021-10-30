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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeaderUserProfileTableViewCell.self, forCellReuseIdentifier: "Header")
        tableView.register(FollowersTableViewCell.self, forCellReuseIdentifier: "Followers")
        return tableView
    }()
    
    init(frame: CGRect, profile: ProfileData) {
        self.profile = profile
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
        return UITableViewCell()
    }
    
    
}
