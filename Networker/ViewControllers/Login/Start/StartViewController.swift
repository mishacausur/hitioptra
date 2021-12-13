//
//  StartViewController.swift
//  Networker
//
//  Created by Misha Causur on 19.10.2021.
//

import UIKit

class StartViewController: UIViewController, ViewController {
    
    typealias RootView = StartView
    
    var viewModel: StartViewOutput
    
    init(viewModel: StartViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().nextButtonTappedCompletion = {
            self.viewModel.coordinator?.eventOccurred(with: .authorized, with: nil)
        }
    }
    
    override func loadView() {
        let view = StartView()
        self.view = view
    }

}
