//
//  FeedTableView.swift
//  Networker
//
//  Created by Misha Causur on 22.10.2021.
//

import Foundation
import UIKit
import ViewAnimator

class FeedTableView: UIView {
    
    var posts1: [Post]?
    
    var users: [UserProfile]?
    
    var liked: ((Int, Int)->())?
    
    var disliked: ((Int, Int)->())?
    
    var tappedToProfile: ((Post)->())?
    
    var refresh: (()->())?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        animator()
        configureRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = UIColor.init(named: "DarkViolet")
        tableView.refreshControl?.attributedTitle = NSAttributedString.init("Обновить")
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
//        posts.removeAll()
        refresh?()
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func animator() {
        let animation = AnimationType.from(direction: .top, offset: 500)
        UIView.animate(views: tableView.visibleCells, animations: [animation], initialAlpha: 0, finalAlpha: 1, delay: 0.2, duration: 0.4)
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
        guard let posts = posts1 else { return 0 }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        guard var posts = posts1 else { return UITableViewCell() }
        posts = posts.sorted(by: { $0.date > $1.date })
        cell.configureCellWithData(post: posts[indexPath.row])
        
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
        
        cell.tapped = {
            self.tappedToProfile?(posts[indexPath.row])
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


