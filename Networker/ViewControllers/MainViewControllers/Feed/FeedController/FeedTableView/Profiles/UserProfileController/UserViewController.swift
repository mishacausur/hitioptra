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
            self.coordinator?.eventOccurred(with: .dismiss, with: nil)
        }
        view().liked = { [weak self] (index, likes) in
            self?.viewModel.like(index: index, likes: likes)
        }
        view().disliked = { [weak self] (index, likes) in
            self?.viewModel.unlike(index: index, likes: likes)
        }
        view().refresh = { [weak self] in
            self?.viewModel.getProfile()
        }
        viewModel.getProfile()
    }
    
    override func loadView() {
        let view = UserProfileView()
        self.view = view
    }
}

extension UserViewController: UserViewInput {
    
    func configureViewWithData(profile: ProfileData, posts: [Post]) {
        view().configureViewWithData(profile: profile, posts: posts)
    }
}
