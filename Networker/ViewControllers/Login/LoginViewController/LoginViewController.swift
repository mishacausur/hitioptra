//
//  LoginViewController.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import UIKit

final class LoginViewController: UIViewController, ViewController, Coordinating {
    
    typealias RootView = LoginView
    
    var coordinator: Coordinator?
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view().animation()
    }
    
    override func viewDidLoad() {
        view().animation()
        super.viewDidLoad()
        view().completion = {
            self.coordinator?.eventOccurred(with: .toRegistration, with: nil)
        }
    }

    override func loadView() {
        let view = LoginView()
        self.view = view
    }

}

