//
//  TabBarViewController.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var coordinator: AppCoordinator?
    
    var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedViewModel = FeedViewModel()
        let feedVC = FeedViewController(viewModel: feedViewModel)
        feedViewModel.viewInput = feedVC
        let feedNavVC = configureViewControllers(viewController: feedVC, title: "Главная", imageName: "house.circle.fill")
        feedVC.coordinator = coordinator
        
        let profileVC = ProfileViewController()
        let profileNavVC = configureViewControllers(viewController: profileVC, title: "Профиль", imageName: "person.circle.fill")
        profileVC.coordinator = coordinator
    
        
        let favoriteVC = FavoriteViewController()
        let favoriteNavVC = configureViewControllers(viewController: favoriteVC, title: "Избранное", imageName: "star.circle.fill")
        favoriteVC.coordinator = coordinator

        viewControllers = [feedNavVC, profileNavVC, favoriteNavVC]
        
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = UIColor(named: "BackgroundViolet")
        tabBar.alpha = 0.6
        tabBar.layer.borderColor = UIColor(named: "DarkViolet")?.cgColor
        tabBar.layer.borderWidth = 0.3
        tabBar.tintColor = UIColor(named: "DarkViolet")
    }
    
    private func configureViewControllers(viewController: UIViewController, title: String, imageName: String)-> UINavigationController {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.barTintColor = UIColor(named: "DarkViolet")
        navVC.navigationBar.tintColor = UIColor(named: "DarkViolet")
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "DarkViolet"), NSAttributedString.Key.font: UIFont(name: "VenrynSans-Regular", size: 24)]
        navVC.title = title
        navVC.tabBarItem.image = UIImage(systemName: imageName)
        return navVC
    }
}
