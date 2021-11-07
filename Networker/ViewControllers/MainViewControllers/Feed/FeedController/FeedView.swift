//
//  FeedView.swift
//  Networker
//
//  Created by Misha Causur on 31.10.2021.
//

import UIKit
import ViewAnimator
import Lottie

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
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("75280-infinity-loader")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView = FeedTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "BackgroundViolet")
        configureViews()
        animationView.loopMode = .loop
        animationView.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView(posts: [Post], users: [UserProfile]) {
        tableView.posts1 = posts
        tableView.users = users
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

        let animation = AnimationType.from(direction: .top, offset: 1000)
        UIView.animate(views: [tableView], animations: [animation], initialAlpha: 0, finalAlpha: 1, delay: 0.2, duration: 0.8) {
            self.animationView.removeFromSuperview()
        }
    }
        
    private func configureViews() {
        
        self.addSubviews(searchButton, titleLabel, bellButton, scrollView)
        scrollView.addSubviews(animationView, tableView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alpha = 1
        let constraints = [
            
            searchButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            
            titleLabel.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bellButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            bellButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 260),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor),
        
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func signOut() {
        signOutTapped?()
    }
    
    @objc private func search() {
        
    }
}
