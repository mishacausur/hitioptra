//
//  FeedViewController.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import UIKit
import FirebaseDatabase

class FeedViewController: UIViewController {

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
        view.backgroundColor = UIColor(named: "BackgroundViolet")
        title = "Новости"
        configureViews()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "bell"))
    }
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        var attributedString = AttributedString.init(stringLiteral: "выйти")
        attributedString.font = UIFont(name: "VenrynSans-Light", size: 18)
        button.configuration?.attributedTitle = attributedString
        button.configuration?.buttonSize = .large
        button.configuration?.baseForegroundColor = UIColor(named: "DarkViolet")
        return button
    }()
    
    @objc private func signOut() {
        viewModel.signOut()
    }
    
    @objc private func search() {
        
    }
    private func configureViews() {
        view.addSubviews(loginButton)
        let constraints = [
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension FeedViewController: FeedViewInput {
    
}
