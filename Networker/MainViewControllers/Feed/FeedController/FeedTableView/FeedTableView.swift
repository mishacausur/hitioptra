//
//  FeedTableView.swift
//  Networker
//
//  Created by Misha Causur on 22.10.2021.
//

import Foundation
import UIKit
import SkeletonView

class FeedTableView: UIView {
    
    var posts: [Post]
    var users: [UserProfile]
    
    var liked: ((Int, Int)->())?
    
    var disliked: ((Int, Int)->())?
    
    var tappedToProfile: ((Post)->())?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.init(named: "DarkViolet")
        tableView.separatorColor = UIColor(named: "Accent Blue")
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    init(frame: CGRect, posts: [Post], users: [UserProfile]) {
        self.posts = posts.sorted(by: { $0.date > $1.date })
        self.users = users
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(tableView)
        tableView.backgroundColor = .white
        [tableView.topAnchor.constraint(equalTo: self.topAnchor),
         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
    }
}

extension FeedTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.configureCellWithData(post: posts[indexPath.row])
        
        var isLiked = posts[indexPath.row].isLiked {
            didSet {
                DispatchQueue.main.async {
                    cell.footer.likeIcon.setImage(self.posts[indexPath.row].isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
                    if self.posts[indexPath.row].isLiked == false {
                        self.posts[indexPath.row].likes -= 1
                        cell.footer.likeLabel.text = "\(self.posts[indexPath.row].likes)"
                        self.disliked?(self.posts[indexPath.row].id - 1, self.posts[indexPath.row].likes)
                    } else {
                        self.posts[indexPath.row].likes += 1
                        cell.footer.likeLabel.text = "\(self.posts[indexPath.row].likes)"
                        self.liked?(self.posts[indexPath.row].id - 1, self.posts[indexPath.row].likes)
                    }
                }
            }
        }
        
        cell.completion = {
            isLiked.toggle()
            self.posts[indexPath.row].isLiked.toggle()
        }
        
        cell.tapped = {
            self.tappedToProfile?(self.posts[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FeedHeaderView()
        header.users = users
        return header
    }
}


