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
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM"
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
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
        cell.postTextLabel.text = posts[indexPath.row].text
        cell.userName.text = posts[indexPath.row].author
        cell.userType.text = posts[indexPath.row].type
        cell.postImage.image = posts[indexPath.row].image
        let date = Date(timeIntervalSince1970: TimeInterval(posts[indexPath.row].date))
        cell.dateLabel.text = dateFormatter.string(from: date) + " в " + timeFormatter.string(from: date)
        cell.footer.likeLabel.text = "\(posts[indexPath.row].likes)"
        cell.footer.likeIcon.setImage(posts[indexPath.row].isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        cell.footer.commentLabel.text = "\(posts[indexPath.row].comments)"
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
        
        let autor = posts[indexPath.row].author
        switch autor {
        case "Cosmo":
            cell.userImage.image = UIImage(named: "cosmo")
        case "Science and Facts":
            cell.userImage.image = UIImage(named: "science")
        case "Homo Sapiens":
            cell.userImage.image = UIImage(named: "person")
        default:
            break
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


