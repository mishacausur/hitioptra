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
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var viewControllers = [Coordinator]()
    
    var navigationViewController: UINavigationController?
    
    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func signIn() {
        let vc = SignInViewController()
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func confirmation(phoneNumber: String) {
        let vc = ConfirmationViewController(phoneNumber: phoneNumber)
        vc.coordinator = self
        navigationViewController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        navigationViewController?.popViewController(animated: true)
    }
}
