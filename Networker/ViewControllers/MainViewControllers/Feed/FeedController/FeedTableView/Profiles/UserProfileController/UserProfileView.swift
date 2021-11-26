//
//  UserProfileView.swift
//  Networker
//
//  Created by Misha Causur on 31.10.2021.
//

import UIKit
import Lottie
import ViewAnimator

class UserProfileView: UIView {
    
    var backButtonTappedCompletion: (()->())?
    
    let backView = UIView()
    
    var liked: ((Int, Int)->())?
    
    var disliked: ((Int, Int)->())?
    
    var refresh: (()->())?
    
    private let scrollView = UIScrollView(frame: .zero)
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.buttonSize = .large
        button.configuration?.image = UIImage(systemName: "arrow.backward")
        button.configuration?.baseForegroundColor = Color.setColor(.darkViolet)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = Font.setFont(.regular, 16)
        label.textColor = Color.setColor(.darkViolet)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("75280-infinity-loader")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView = UserTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        animationView.loopMode = .loop
        animationView.play()
        self.backgroundColor = Color.setColor(.background)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func backButtonTapped() {
        backButtonTappedCompletion?()
    }
    
    
    private func configureViews() {
        self.addSubviews(backView, backButton, userName, animationView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.alpha = 0
        let constraints = [
            
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            
            userName.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            userName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 260),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureViewWithData(profile: ProfileData, posts: [Post]) {
            userName.text = "networker/\(profile.name.lowercased())"
            setupProfileTableView(profile: profile, posts: posts)
            animatedAlpha()
    }
    

    private func setupProfileTableView(profile: ProfileData, posts: [Post]) {
        tableView.posts1 = posts
        tableView.user = profile
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.liked = { [weak self] (index, likes) in
            self?.liked?(index, likes)
        }
        tableView.disliked = { [weak self] (index, likes) in
            self?.disliked?(index, likes)
        }
        tableView.refresh = { [weak self] in
            self?.refresh?()
        }
    
        backView.addSubview(tableView)
        [tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
    }
    
    func animatedAlpha() {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.backView.alpha = 1
            self.animationView.removeFromSuperview()
        }
        animator.startAnimation()
    }
}
