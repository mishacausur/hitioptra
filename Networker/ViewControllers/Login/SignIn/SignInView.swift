//
//  SignInView.swift
//  Networker
//
//  Created by Misha Causur on 31.10.2021.
//

import UIKit

class SignInView: UIView {
    
    var backButtonTappedCompletion: (()->())?
    
    var confirmNumberCompletion: ((String)->())?
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.buttonSize = .large
        button.configuration?.image = UIImage(systemName: "arrow.backward")
        button.configuration?.baseForegroundColor = Color.setColor(.darkViolet)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Зарегистрироваться"
        label.font = Font.setFont(.semibold, 28)
        label.textColor = Color.setColor(.darkViolet)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите номер"
        label.font = Font.setFont(.regular, 18)
        label.textColor = Color.setColor(.darkViolet)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш номер будет использоваться для входа в аккаунт"
        label.font = Font.setFont(.light, 14)
        label.textColor = Color.setColor(.darkViolet)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = Color.setColor(.darkViolet).cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 7 "
        label.font = Font.setFont(.light, 24)
        label.textColor = Color.setColor(.darkViolet)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = Font.setFont(.regular, 24)
        field.keyboardType = .numberPad
        field.textAlignment = .center
        field.addTarget(self, action: #selector(checkNumber), for: .allEvents)
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(string: "Номер телефона", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeHolderColor") as Any])
        field.textColor = UIColor(named: "DarkViolet")
        return field
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(confirmation), for: .touchUpInside)
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
    
    private let agreedLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажимая кнопку “Далее”, Вы принимаете пользовательское Соглашение и политику конфиденциальности"
        label.font = Font.setFont(.light, 14)
        label.textColor = Color.setColor(.darkViolet)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста, введите корректный номер телефона"
        label.font = Font.setFont(.light, 18)
        label.textColor = Color.setColor(.error)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        nextButton.isEnabled = false
        phoneField.delegate = self
        nextButton.alpha = 0
        agreedLabel.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func backButtonTapped() {
        backButtonTappedCompletion?()
    }
    
    @objc private func checkNumber() {
        guard let text = phoneField.text else { return }
        phoneField.text = text.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#")
        if text.count == 14 {
           checkNineCharacter(text: text)
    } else {
        nextButton.isEnabled = false
        nextButton.alpha = 0
    }
}
    
    private func checkNineCharacter(text: String) {
        let nine = text[text.index(text.startIndex, offsetBy: 1)]
        if nine != "9" {
            phoneFieldView.layer.borderColor = Color.setColor(.error).cgColor
            errorLabel.alpha = 1
        } else {
            phoneFieldView.layer.borderColor = Color.setColor(.darkViolet).cgColor
            errorLabel.alpha = 0
            nextButton.isEnabled = true
            nextButton.alpha = 1
            agreedLabel.alpha = 1
        }
    }
    
    @objc private func confirmation() {
        guard let text = phoneField.text else { return }
        confirmNumberCompletion?(text)
    }
    
    private func configureViews() {
        self.addSubviews(backgroundImage, backButton, signInLabel, phoneLabel, infoLabel, phoneFieldView, nextButton, agreedLabel, errorLabel)
        phoneFieldView.addSubviews(firstNumberLabel, phoneField)
        
        let constraints = [
            
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            
            errorLabel.bottomAnchor.constraint(equalTo: signInLabel.topAnchor, constant: -12),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            errorLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            
            signInLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 164),
            signInLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            phoneLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 12),
            phoneLabel.centerXAnchor.constraint(equalTo: signInLabel.centerXAnchor),
        
            infoLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            infoLabel.centerXAnchor.constraint(equalTo: phoneLabel.centerXAnchor),
        
            phoneFieldView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            phoneFieldView.centerXAnchor.constraint(equalTo: infoLabel.centerXAnchor),
            phoneFieldView.widthAnchor.constraint(equalToConstant: 268),
            phoneFieldView.heightAnchor.constraint(equalTo: nextButton.heightAnchor),
            
            firstNumberLabel.topAnchor.constraint(equalTo: phoneFieldView.topAnchor),
            firstNumberLabel.bottomAnchor.constraint(equalTo: phoneFieldView.bottomAnchor),
            firstNumberLabel.leadingAnchor.constraint(equalTo: phoneFieldView.leadingAnchor, constant: 16),
            
            phoneField.topAnchor.constraint(equalTo: phoneFieldView.topAnchor),
            phoneField.bottomAnchor.constraint(equalTo: phoneFieldView.bottomAnchor),
            phoneField.widthAnchor.constraint(equalToConstant: 248),
            phoneField.trailingAnchor.constraint(equalTo: phoneFieldView.trailingAnchor),
        
            nextButton.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 12),
            nextButton.centerXAnchor.constraint(equalTo: phoneFieldView.centerXAnchor),
        
            agreedLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 12),
            agreedLabel.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            agreedLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            agreedLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension SignInView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 14
    }
}
