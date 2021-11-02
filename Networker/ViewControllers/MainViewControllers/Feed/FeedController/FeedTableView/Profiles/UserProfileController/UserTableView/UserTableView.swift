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
    
    var posts: [Post]
    
    var liked: ((Int, Int)->())?
    
    var disliked: ((Int, Int)->())?
  
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
    
    init(frame: CGRect, profile: ProfileData, posts: [Post]) {
        self.profile = profile
        self.posts = posts.sorted(by: { $0.date > $1.date })
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
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        if section == 1 {
            return posts.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
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
        }
       
        if (indexPath.section == 1) {
            let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! FeedTableViewCell
            cell.configureCellWithData(post: posts[indexPath.row])
            
            var isLiked = posts[indexPath.row].isLiked {
                didSet {
                    DispatchQueue.main.async {
                        cell.footer.likeIcon.setImage(self.posts[indexPath.row].isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
                        if self.posts[indexPath.row].isLiked == false {
                            self.posts[indexPath.row].likes -= 1
                            cell.footer.likeLabel.text = "\(self.posts[indexPath.row].likes)"
                            self.disliked?(self.posts[indexPath.row].id, self.posts[indexPath.row].likes)
                        } else {
                            self.posts[indexPath.row].likes += 1
                            cell.footer.likeLabel.text = "\(self.posts[indexPath.row].likes)"
                            self.liked?(self.posts[indexPath.row].id, self.posts[indexPath.row].likes)
                        }
                    }
                }
            }
            
            cell.completion = {
                isLiked.toggle()
                self.posts[indexPath.row].isLiked.toggle()
            }
            
            return cell
        
        }
        return UITableViewCell()
    }
   
    
    
    
}
