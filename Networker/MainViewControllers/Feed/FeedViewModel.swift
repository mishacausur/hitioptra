//
//  FeedViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import FirebaseAuth
protocol FeedViewInput: AnyObject {
    
}

protocol FeedViewOutput {
    func signOut()
    
}

class FeedViewModel: FeedViewOutput {
    
    weak var viewInput: FeedViewInput?
    
    var coordinator: AppCoordinator?
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch let error {
            print(error)
        }
        coordinator?.startWithAuth()
    }
}
