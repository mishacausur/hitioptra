//
//  ConfirmationViewController.swift
//  Networker
//
//  Created by Misha Causur on 17.10.2021.
//

import UIKit

class ConfirmationViewController: UIViewController, ViewController, Coordinating {

    var coordinator: Coordinator?
    
    var viewModel: ConfirmationViewOutput
    
    typealias RootView = ConfirmationView
    
    var phoneNumber: String

    override func viewDidLoad() {
        super.viewDidLoad()
        view().confirmCodeCompletion = { [weak self] text in
            self?.checkCode(text: text)
        }
        view().backButtonTappedCompletion = { [weak self] in
            self?.coordinator?.eventOccurred(with: .dismiss, with: nil)
        }
    }
    
    init(phoneNumber: String, viewModel: ConfirmationViewOutput) {
        self.phoneNumber = phoneNumber
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = ConfirmationView(frame: .zero, phoneNumber: phoneNumber)
        self.view = view
    }
    
    private func checkCode(text: String) {
        
        viewModel.verify(code: text) { [weak self] value in
            guard value else {
                self?.invalidCode()
                return
            }
            self?.coordinator?.eventOccurred(with: .toSuccess, with: nil)
        }
    }

    private func invalidCode() {
        let alarmController = UIAlertController(title: "Неверный код", message: "Проверьте введеный код из СМС", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alarmController.addAction(cancel)
        
        present(alarmController, animated: true)
    }
}

extension ConfirmationViewController: ConfirmationViewInput {
    
}
