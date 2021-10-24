//
//  FeedViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import FirebaseAuth
protocol FeedViewInput: AnyObject {
    func configureTableView(posts: [Post])
    func animatedAlpha()
}

protocol FeedViewOutput {
    var users: [UserProfile]? { get }
    var posts: [Post]? { get }
    func getContent()
    func signOut()
}

class FeedViewModel: FeedViewOutput {
    
    
    weak var viewInput: FeedViewInput?
    
    var coordinator: AppCoordinator?
    
    var posts: [Post]? = [] {
        didSet {
            guard posts != nil else { return }
            DispatchQueue.main.async {
                
            }
        }
    }
    
    var users: [UserProfile]?
    
    let postNames = ["post1", "post2", "post3", "post4", "post5", "post6"]
    
    func getContent() {
        APIManager.shared.getContent(name: postNames) { posts in
            DispatchQueue.main.async {
                self.viewInput!.configureTableView(posts: posts)
                self.viewInput!.animatedAlpha()
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
