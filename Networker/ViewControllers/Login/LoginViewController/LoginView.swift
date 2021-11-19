//
//  LoginView.swift
//  Networker
//
//  Created by Misha Causur on 31.10.2021.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    var completion: (()->())?
    
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
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func signIn(){
        completion?()
    }
    
    func animation() {
        circleImageLeft.rotateBack()
    }

    private func configureViews() {
        self.addSubviews(backgroundImage, circleImageLeft, signInButton, heartLogo, loginButton, appLabel)
 
        let constraints = [
            
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            appLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            appLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            heartLogo.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 22),
            heartLogo.widthAnchor.constraint(equalToConstant: 74),
            heartLogo.heightAnchor.constraint(equalTo: heartLogo.widthAnchor),
            heartLogo.centerXAnchor.constraint(equalTo: appLabel.centerXAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: appLabel.centerYAnchor, constant: 184),
        
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor),
            loginButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
        
            circleImageLeft.widthAnchor.constraint(equalToConstant: 600),
            circleImageLeft.heightAnchor.constraint(equalTo: circleImageLeft.widthAnchor),
            circleImageLeft.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: 88),
            circleImageLeft.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -300)]
    
        NSLayoutConstraint.activate(constraints)
    }
}
