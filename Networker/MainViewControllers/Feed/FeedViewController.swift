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
    
    let scrollView = UIScrollView(frame: .zero)
    
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
        viewModel.getContent()
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
    

    func configureTableView(posts: [Post]) {
        guard let users = viewModel.users else { return }
        let tableView: FeedTableView = {
            let tableView = FeedTableView(frame: .zero, posts: posts, users: users)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        
        scrollView.addSubview(tableView)

        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureViews() {
        
        view.addSubviews(loginButton, scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alpha = 0
        
        let constraints = [
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func animatedAlpha() {
           let animator = UIViewPropertyAnimator(duration: 0.7, curve: .linear) {
               self.scrollView.alpha = 1
           }
        animator.startAnimation()
    }
}

extension FeedViewController: FeedViewInput {
    
}
