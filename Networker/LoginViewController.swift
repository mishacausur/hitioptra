//
//  LoginViewController.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Приветики!"
        label.font = UIFont(name: "VenrynSans-Light", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundViolet")
        configureViews()
        
    }

    private func configureViews() {
        view.addSubview(label)
        
        let constraints = [
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }

}

