//
//  AppCoordinator.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var viewControllers: [Coordinator] { get set }
    var navigationViewController: UINavigationController? { get set }
    
    func startWithAuth()
    func startCurrentUserLoggedIn()
}

class AppCoordinator: Coordinator {
    
    var viewControllers = [Coordinator]()
    
    var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    func startWithAuth() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func startCurrentUserLoggedIn() {
        guard let navVC = navigationViewController else { fatalError() }
        let tabBarVC = TabBarViewController(navController: navVC, coordinator: self)
        navigationViewController?.pushViewController(tabBarVC, animated: true)
    }
    func startWithSuccess() {
        let vc = StartViewController()
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    
    func signIn() {
        let viewModel = SignInViewModel()
        let vc = SignInViewController(viewModel: viewModel)
        viewModel.viewInput = vc
        viewModel.coordinator = self
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func confirmation(phoneNumber: String) {
        let viewModel = ConfirmationViewModel()
        let vc = ConfirmationViewController(phoneNumber: phoneNumber, viewModel: viewModel)
        viewModel.viewInput = vc
        viewModel.coordinator = self
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func toUserProfile(profileID: String) {
        let viewModel = UserViewModel(author: profileID)
        let vc = UserViewController(viewModel: viewModel)
        viewModel.viewInput = vc
        viewModel.coordinator = self
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func signOut() {
        navigationViewController?.popToRootViewController(animated: true)
    }
    
    func dismiss() {
        navigationViewController?.popViewController(animated: true)
    }
}
