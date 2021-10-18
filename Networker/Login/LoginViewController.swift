//
//  LoginViewController.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "networker"
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 54)
        label.textColor = UIColor(named: "DarkViolet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .bordered()
        var attributedString = AttributedString.init(stringLiteral: "Зарегистрироваться")
        attributedString.font = UIFont(name: "VenrynSans-Regular", size: 24)
        button.configuration?.attributedTitle = attributedString
        button.configuration?.buttonSize = .large
        button.configuration?.baseBackgroundColor = UIColor(named: "DarkViolet")
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        var attributedString = AttributedString.init(stringLiteral: "У меня уже есть аккаунт")
        attributedString.font = UIFont(name: "VenrynSans-Light", size: 18)
        button.configuration?.attributedTitle = attributedString
        button.configuration?.buttonSize = .large
        button.configuration?.baseForegroundColor = UIColor(named: "DarkViolet")
        return button
    }()
    
    private let circleImageLeft: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "circle")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heartLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "heart")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc private func signIn(){
        coordinator?.signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleImageLeft.rotateBack()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "BackgroundViolet")
        configureViews()
        circleImageLeft.rotateBack()
        super.viewDidLoad()
        
    }

    private func configureViews() {
        view.addSubviews(circleImageLeft, signInButton, heartLogo, loginButton, appLabel)
 
        
        let constraints = [
            appLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heartLogo.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 22),
            heartLogo.widthAnchor.constraint(equalToConstant: 74),
            heartLogo.heightAnchor.constraint(equalTo: heartLogo.widthAnchor),
            heartLogo.centerXAnchor.constraint(equalTo: appLabel.centerXAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: appLabel.centerYAnchor, constant: 184),
        
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor),
            loginButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
        
            circleImageLeft.widthAnchor.constraint(equalToConstant: 600),
            circleImageLeft.heightAnchor.constraint(equalTo: circleImageLeft.widthAnchor),
            circleImageLeft.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 88),
            circleImageLeft.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)]
    
        NSLayoutConstraint.activate(constraints)
        
        print(UIScreen.main.bounds)
    }

}

