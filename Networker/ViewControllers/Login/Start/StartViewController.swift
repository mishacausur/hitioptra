//
//  StartViewController.swift
//  Networker
//
//  Created by Misha Causur on 19.10.2021.
//

import UIKit

class StartViewController: UIViewController, ViewController, Coordinating {
    
    typealias RootView = StartView

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().nextButtonTappedCompletion = {
            self.coordinator?.eventOccurred(with: .authorized, with: nil)
        }
    }
    
    override func loadView() {
        let view = StartView()
        self.view = view
    }

}
