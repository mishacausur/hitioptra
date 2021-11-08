//
//  FavoriteViewController.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import UIKit

class FavoriteViewController: UIViewController, ViewController, Coordinating {
  
    typealias RootView = FavortiteView
    
    var coordinator: Coordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view().startAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = FavortiteView()
        self.view = view
    }

}
