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
        view().liked = { [self] (index, likes) in
            viewModel.like(index: index, likes: likes)
        }
        view().disliked = { [self] (index, likes) in
            viewModel.unlike(index: index, likes: likes)
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
