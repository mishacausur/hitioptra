//
//  FeedViewController.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import UIKit
import FirebaseDatabase

class FeedViewController: UIViewController, ViewController {
    
    typealias RootView = FeedView

    var coordinator: AppCoordinator?
    
    var viewModel: FeedViewOutput
    
    init(viewModel: FeedViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view().signOutTapped = {
            self.viewModel.signOut()
        }
        view().toUser = { user in
            self.coordinator?.toUserProfile(profileID: user)
        }
        viewModel.getContent()
    }
    
    override func loadView() {
        let view = FeedView()
        self.view = view
    }
}

extension FeedViewController: FeedViewInput {
    
    func configureTableView(posts: [Post]) {
        guard let users = viewModel.users else { return }
        view().configureTableView(posts: posts, users: users)
        view().liked = { [self] (index, likes) in
            viewModel.like(index: index, likes: likes)
        }
        view().disliked = { [self] (index, likes) in
            viewModel.unlike(index: index, likes: likes)
        }
    }
    
    func animatedAlpha() {
        view().animatedAlpha()
    }
}
