//
//  LoginViewController.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import UIKit

final class LoginViewController: UIViewController, ViewController {
    
    typealias RootView = LoginView
    var coordinator: AppCoordinator?
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view().animation()
    }
    
    override func viewDidLoad() {
        view().animation()
        super.viewDidLoad()
        view().completion = {
            self.coordinator?.signIn()
        }
    }

    override func loadView() {
        let view = LoginView()
        self.view = view
    }

}

