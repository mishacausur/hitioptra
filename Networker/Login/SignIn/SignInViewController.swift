//
//  SignInViewController.swift
//  Networker
//
//  Created by Misha Causur on 17.10.2021.
//

import UIKit

final class SignInViewController: UIViewController, ViewController {

    typealias RootView = SignInView
    
    var coordinator: AppCoordinator?
    
    var viewModel: SignInViewOutput
    
    init(viewModel: SignInViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().backButtonTappedCompletion = {
            self.coordinator?.dismiss()
        }
        view().confirmNumberCompletion = { [self] text in
            confirmation(text: text)
        }
    }
    
    override func loadView() {
        let view = SignInView()
        self.view = view
    }

    private func confirmation(text: String) {
        viewModel.auth(phone: text) { value in
            guard value else { return }
            self.coordinator?.confirmation(phoneNumber: text)
        }
    }
}

extension SignInViewController: SignInViewInput {
}
