//
//  ProfileView.swift
//  Networker
//
//  Created by Misha Causur on 13.11.2021.
//

import Foundation
import UIKit
import Lottie

class ProfileView: UIView {
    
    let backView = UIView()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Mishutto"
        label.font = UIFont(name: "VenrynSans-Regular", size: 16)
        label.textColor = UIColor(named: "DarkViolet")
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
    
    func configureProfile(profile: ProfileData) {
        let tableView = ProfileTableView(frame: .zero, user: profile)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(tableView)
        [tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 46),
         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
        animatedAlpha()
    }
    
    private func configureViews() {
        self.addSubviews(backView, userName, animationView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.alpha = 0
        
        let constraints = [
            
            userName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
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
    
    func animatedAlpha() {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.backView.alpha = 1
            self.animationView.removeFromSuperview()
        }
        animator.startAnimation()
    }
    
}
