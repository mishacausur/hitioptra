//
//  FavortiteView.swift
//  Networker
//
//  Created by Misha Causur on 02.11.2021.
//

import UIKit
import Lottie

class FavortiteView: UIView {
    
    let animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("71420-sparkle")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heartLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "networker")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "Здесь будут храниться твои любимые публикации"
        label.font = Font.setFont(.regular, 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Color.setColor(.darkViolet)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.setColor(.background)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func configureViews() {
        self.addSubviews(animationView, heartLogo, appLabel)

        let constraints = [
         
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            animationView.widthAnchor.constraint(equalTo: self.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor),
        
            heartLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            heartLogo.widthAnchor.constraint(equalToConstant: 250),
            heartLogo.heightAnchor.constraint(equalTo: heartLogo.widthAnchor),
            heartLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            appLabel.topAnchor.constraint(equalTo: heartLogo.bottomAnchor),
            appLabel.centerXAnchor.constraint(equalTo: heartLogo.centerXAnchor),
            appLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 34),
            appLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -34),]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
