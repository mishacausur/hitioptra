//
//  StartViewController.swift
//  Networker
//
//  Created by Misha Causur on 19.10.2021.
//

import UIKit

class StartViewController: UIViewController, ViewController {
    
    typealias RootView = StartView

    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().nextButtonTappedCompletion = {
            self.coordinator?.startCurrentUserLoggedIn()
        }
    }
    
    override func loadView() {
        let view = StartView()
        self.view = view
    }

}
