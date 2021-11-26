//
//  StartView.swift
//  Networker
//
//  Created by Misha Causur on 31.10.2021.
//

import UIKit
import Lottie

class StartView: UIView {
    
    var nextButtonTappedCompletion: (()->())?

    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы успешно зарегистрировались"
        label.font = Font.setFont(.semibold, 28)
        label.textColor = Color.setColor(.darkViolet)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите “Далее“ для того, чтобы закончить регистрацию и перейти в сервис"
        label.font = Font.setFont(.light, 14)
        label.textColor = Color.setColor(.darkViolet)
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
        attributedString.font = Font.setFont(.regular, 24)
        button.configuration?.attributedTitle = attributedString
        button.configuration?.buttonSize = .medium
        button.configuration?.baseBackgroundColor = Color.setColor(.darkViolet)
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg4")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        animationView.loopMode = .repeatBackwards(10)
        animationView.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextVC() {
        nextButtonTappedCompletion?()
    }

    private func configureViews() {
        self.addSubviews(backgroundImage, confirmationLabel, animationView, infoLabel, signInButton)
        
        let constraints = [
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
           
            confirmationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 164),
            confirmationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 44),
            confirmationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -44),
        
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 274),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor),
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            infoLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 44),
            infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 44),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -44),
        
            signInButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 44),
            signInButton.centerXAnchor.constraint(equalTo: infoLabel.centerXAnchor),]
        
        NSLayoutConstraint.activate(constraints)
    }

}
