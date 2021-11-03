//
//  FeedView.swift
//  Networker
//
//  Created by Misha Causur on 31.10.2021.
//

import UIKit

class FeedView: UIView {
    
    var signOutTapped: (()->())?
    
    var liked: ((Int, Int)->())?
    
    var disliked: ((Int, Int)->())?
    
    var toUser: ((String)->())?
    
    var refresh: (()->())?
    
    let scrollView = UIScrollView(frame: .zero)
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.buttonSize = .large
        button.configuration?.image = UIImage(systemName: "magnifyingglass")
        button.configuration?.baseForegroundColor = UIColor(named: "DarkViolet")
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Главная"
        label.font = UIFont(name: "VenrynSans-Regular", size: 20)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bellButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.buttonSize = .large
        button.configuration?.image = UIImage(systemName: "bell")
        button.configuration?.baseForegroundColor = UIColor(named: "DarkViolet")
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    private let skeleton: SkeletonView = {
        let view = SkeletonView()
        view.isSkeletonable = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "BackgroundViolet")
        configureViews()
        skeleton.showAnimatedGradientSkeleton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView(posts: [Post], users: [UserProfile]) {
        let tableView: FeedTableView = {
            let tableView = FeedTableView(frame: .zero, posts: posts, users: users)
            tableView.liked = { [self] (index, likes) in
                self.liked?(index, likes)
            }
            tableView.disliked = { [self] (index, likes) in
                self.disliked?(index, likes)
                
            }
            tableView.tappedToProfile = { [self] post in
                self.toUser?(post.author)
            }
            tableView.refresh = {
                self.refresh?()
            }
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        
        scrollView.addSubview(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureViews() {
        
        self.addSubviews(searchButton, titleLabel, bellButton, skeleton, scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alpha = 0
        
        let constraints = [
            
            searchButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            
            titleLabel.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bellButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            bellButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            
            skeleton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            skeleton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            skeleton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            skeleton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func animatedAlpha() {
        let generalViewAnimator = UIViewPropertyAnimator(duration: 0.9, curve: .linear) {
            self.scrollView.alpha = 1
        }
        let skeletonAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
            self.skeleton.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.6))
            self.skeleton.removeFromSuperview()
            generalViewAnimator.startAnimation()
        }
        skeletonAnimator.startAnimation()
        
    }
    
    @objc private func signOut() {
        signOutTapped?()
    }
    
    @objc private func search() {
        
    }
}
