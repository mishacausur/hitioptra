//
//  FeedViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import FirebaseAuth
protocol FeedViewInput: AnyObject {
    
    func configureHistoryView()
    
}

protocol FeedViewOutput {
    var users: [UserProfile]? { get }
    func signOut()
    
}

class FeedViewModel: FeedViewOutput {
    
    weak var viewInput: FeedViewInput?
    
    var coordinator: AppCoordinator?
    
    var users: [UserProfile]? {
        didSet {
            guard viewInput != nil else { return }
            DispatchQueue.main.async {
                self.viewInput!.configureHistoryView()
            }
          
        }
    }
    
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
