//
//  AppCoordinator.swift
//  Networker
//
//  Created by Misha Causur on 08.11.2021.
//

import Foundation
import UIKit 

class AppCoordinator: Coordinator {

    var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
  
    func eventOccurred(with type: Event, with string: String?) {
        
        switch type {
            
        case .toRegistration:
            signIn()
            
        case .toConfirm:
            guard let string = string else { return }
            confirmation(phoneNumber: string)
            
        case .toSuccess:
            startWithSuccess()
            
        case .toUser:
            guard let string = string else { return }
            toUserProfile(profileID: string)
            
        case .dismiss:
            dismiss()
            
        case .start:
            startWithAuth()
            
        case .authorized:
            startCurrentUserLoggedIn()
        }
    }
    
    private func startWithAuth() {
        navigationViewController?.viewControllers.removeAll()
        let vc = LoginViewController()
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    private func startCurrentUserLoggedIn() {
        navigationViewController?.viewControllers.removeAll()
        let tabBarVC = TabBarViewController(coordinator: self)
        navigationViewController?.pushViewController(tabBarVC, animated: true)
    }

    private func startWithSuccess() {
        let vc = StartViewController()
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    private func signIn() {
        let viewModel = SignInViewModel()
        let vc = SignInViewController(viewModel: viewModel)
        viewModel.viewInput = vc
        viewModel.coordinator = self
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    private func confirmation(phoneNumber: String) {
        let viewModel = ConfirmationViewModel()
        let vc = ConfirmationViewController(phoneNumber: phoneNumber, viewModel: viewModel)
        viewModel.viewInput = vc
        viewModel.coordinator = self
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    private func toUserProfile(profileID: String) {
        let viewModel = UserViewModel(author: profileID)
        let vc = UserViewController(viewModel: viewModel)
        viewModel.viewInput = vc
        viewModel.coordinator = self
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }

    private func dismiss() {
        navigationViewController?.popViewController(animated: true)
    }
}
