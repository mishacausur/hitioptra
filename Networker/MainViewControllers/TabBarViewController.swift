//
//  TabBarViewController.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var coordinator: AppCoordinator
    
    var navController: UINavigationController
    
    init(navController: UINavigationController, coordinator: AppCoordinator) {
        self.navController = navController
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = UIColor.gray
        tabBar.layer.borderColor = UIColor(named: "DarkViolet")?.cgColor
        tabBar.layer.borderWidth = 0.3
        tabBar.tintColor = UIColor(named: "DarkViolet")
        blurredTabBar()
        setControllers() 
    }
    private func blurredTabBar() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(blurView)
        [blurView.topAnchor.constraint(equalTo: tabBar.topAnchor),
         blurView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
         blurView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
         blurView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)].forEach { $0.isActive = true }
    }
    
    private func setControllers() {
        
        let feedViewModel = FeedViewModel()
        
        let feedVC = FeedViewController(viewModel: feedViewModel)
        feedViewModel.viewInput = feedVC
        feedViewModel.users = users.users
        let feedNavVC = configureViewControllers(viewController: feedVC, title: "Главная", imageName: "house.circle.fill")
        feedVC.coordinator = coordinator
        feedViewModel.coordinator = coordinator
        
        let profileVC = ProfileViewController()
        let profileNavVC = configureViewControllers(viewController: profileVC, title: "Профиль", imageName: "person.circle.fill")
        profileVC.coordinator = coordinator
    
        
        let favoriteVC = FavoriteViewController()
        let favoriteNavVC = configureViewControllers(viewController: favoriteVC, title: "Избранное", imageName: "star.circle.fill")
        favoriteVC.coordinator = coordinator

        viewControllers = [feedNavVC, profileNavVC, favoriteNavVC]
        
    }
    
    private func configureViewControllers(viewController: UIViewController, title: String, imageName: String)-> UINavigationController {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.isHidden = true
        navVC.title = title
        navVC.tabBarItem.image = UIImage(systemName: imageName)
        return navVC
    }
}
