//
//  UserTableView.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import UIKit
import ViewAnimator

class UserTableView: UIView {
    
    var user: ProfileData?
    
    var posts1: [Post]?
    
    var liked: ((Int, Int)->())?
    
    var disliked: ((Int, Int)->())?
    
    var refresh: (()->())?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = Color.setColor(.darkViolet)
        tableView.refreshControl?.attributedTitle = NSAttributedString.init("Обновить")
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        refresh?()
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
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
    
    func animator() {
        let animation = AnimationType.from(direction: .right, offset: 800)
        UIView.animate(views: tableView.visibleCells, animations: [animation], initialAlpha: 1, finalAlpha: 1, delay: 0.2, duration: 0.9)
    }
    
}


extension UserTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        guard let posts = posts1 else { return 0 }
        if section == 0 {
            return 3
        }
        if section == 1 {
            return posts.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let posts = posts1 else { return nil }

        if section == 1 {
            let header = UserProfileHeaderForSectionView()
            header.configure(count: posts.count)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard var posts = posts1, let profile = user else { return UITableViewCell() }
        posts = posts.sorted(by: { $0.date > $1.date })
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
            cell.topLine.alpha = 0.3
            
            var isLiked = posts[indexPath.row].isLiked {
                didSet {
                    DispatchQueue.main.async {
                        cell.footer.likeIcon.setImage(posts[indexPath.row].isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
                        if posts[indexPath.row].isLiked == false {
                            posts[indexPath.row].likes -= 1
                            cell.footer.likeLabel.text = "\(posts[indexPath.row].likes)"
                            self.disliked?(posts[indexPath.row].id, posts[indexPath.row].likes)
                        } else {
                            posts[indexPath.row].likes += 1
                            cell.footer.likeLabel.text = "\(posts[indexPath.row].likes)"
                            self.liked?(posts[indexPath.row].id, posts[indexPath.row].likes)
                        }
                    }
                }
            }
            cell.completion = {
                isLiked.toggle()
                posts[indexPath.row].isLiked.toggle()
            }
            return cell
        }
        return UITableViewCell()
    }
}
