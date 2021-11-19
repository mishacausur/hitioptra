//
//  ProfileViewController.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import UIKit

class ProfileViewController: UIViewController, Coordinating, ViewController {
    
    typealias RootView = ProfileView

    var coordinator: Coordinator?
    
    var viewModel: ProfileViewOutput
    
    init(viewModel: ProfileViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.getProfile()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = ProfileView()
        self.view = view
    }
    
}

extension ProfileViewController: ProfileViewInput {
    
    func configureProfile(profile: ProfileData) {
        view().configureProfile(profile: profile)
    }
}
