//
//  StartViewController.swift
//  Networker
//
//  Created by Misha Causur on 19.10.2021.
//

import UIKit
import Lottie

class StartViewController: UIViewController {

    var coordinator: AppCoordinator?
    
    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы успешно зарегистрировались"
        label.font = UIFont(name: "VenrynSans-SemiBold", size: 28)
        label.textColor = UIColor(named: "DarkViolet")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите “Далее“ для того, чтобы закончить регистрацию и перейти в сервис"
        label.font = UIFont(name: "VenrynSans-Light", size: 14)
        label.textColor = UIColor(named: "DarkViolet")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("65696-tick-animation-success-feedback")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .bordered()
        var attributedString = AttributedString.init(stringLiteral: "Далее")
        attributedString.font = UIFont(name: "VenrynSans-Regular", size: 24)
        button.configuration?.attributedTitle = attributedString
        button.configuration?.buttonSize = .medium
        button.configuration?.baseBackgroundColor = UIColor(named: "DarkViolet")
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg4")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundViolet")
        configureViews()
        animationView.loopMode = .repeatBackwards(10)
        animationView.play()
//        nextVC()
    }
    
    @objc private func nextVC() {
        
        coordinator?.startCurrentUserLoggedIn()
    }

    private func configureViews() {
        view.addSubviews(backgroundImage, confirmationLabel, animationView, infoLabel, signInButton)
        
        let constraints = [
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           
            confirmationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 164),
            confirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            confirmationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
        
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 274),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            infoLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 44),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
        
            signInButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 44),
            signInButton.centerXAnchor.constraint(equalTo: infoLabel.centerXAnchor),]
        
        NSLayoutConstraint.activate(constraints)
    }

}
