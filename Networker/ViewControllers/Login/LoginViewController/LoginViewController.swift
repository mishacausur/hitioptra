//
//  LoginViewController.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import UIKit

final class LoginViewController: UIViewController, ViewController {
    
    typealias RootView = LoginView
    
    var viewModel: LoginViewOutput
    
    init(viewModel: LoginViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view().animation()
    }
    
    override func viewDidLoad() {
        view().animation()
        super.viewDidLoad()
        view().completion = {
            self.viewModel.coordinator?.eventOccurred(with: .toRegistration, with: nil)
        }
    }

    override func loadView() {
        let view = LoginView()
        self.view = view
    }

}

extension LoginViewController: LoginViewInput {
    
}
