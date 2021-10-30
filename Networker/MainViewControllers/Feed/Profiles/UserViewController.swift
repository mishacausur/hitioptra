//
//  UserViewController.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import UIKit

class UserViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    var viewModel: UserViewOutput
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.buttonSize = .large
        button.configuration?.image = UIImage(systemName: "arrow.backward")
        button.configuration?.baseForegroundColor = UIColor(named: "DarkViolet")
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VenrynSans-Regular", size: 16)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: UserViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundViolet")
        viewModel.getProfile()
        configureViews()
    }
    
    @objc private func backButtonTapped() {
        coordinator?.dismiss()
    }
    
    
    
    private func configureViews() {
        view.addSubviews(backButton, userName)
      
        let constraints = [
         
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            
            userName.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupProfileTableView(profile: ProfileData) {
        let tableView: UserTableView = {
            let tableView = UserTableView(frame: .zero, profile: profile)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        
        view.addSubview(tableView)
        [tableView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6),
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach { $0.isActive = true }
    }
}

extension UserViewController: UserViewInput {
    
    func configureViewWithData(profile: ProfileData) {
        DispatchQueue.main.async {
            self.userName.text = "networker/\(profile.name.lowercased())"
            self.setupProfileTableView(profile: profile)
        }
      
    }
}
