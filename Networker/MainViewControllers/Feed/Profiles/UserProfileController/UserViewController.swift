//
//  UserViewController.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class UserViewController: UIViewController, ViewController {
    
    typealias RootView = UserProfileView
    
    var coordinator: AppCoordinator?
    
    var viewModel: UserViewOutput
   
    init(viewModel: UserViewOutput) {
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
        viewModel.getProfile()
    }
    
    override func loadView() {
        let view = UserProfileView()
        self.view = view
    }
}

extension UserViewController: UserViewInput {
    
    func configureViewWithData(profile: ProfileData) {
        view().configureViewWithData(profile: profile)
    }
}
