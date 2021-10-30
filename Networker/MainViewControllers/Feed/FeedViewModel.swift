//
//  FeedViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import FirebaseAuth

protocol FeedViewInput: AnyObject {
    
    var shouldAnimate: Bool { get set }
    func configureTableView(posts: [Post])
    func animatedAlpha()
    
}

protocol FeedViewOutput {
    
    var users: [UserProfile]? { get }
    var posts: [Post]? { get }
    func getContent()
    func like(index: Int, likes: Int)
    func unlike(index: Int, likes: Int)
    func signOut()
    
}

class FeedViewModel: FeedViewOutput {
    
    weak var viewInput: FeedViewInput?
    
    var coordinator: AppCoordinator?
    
    var posts: [Post]? = []
    
    var users: [UserProfile]?
    
    let postNames = ["post1", "post2", "post3", "post4", "post5", "post6"]
    
    func getContent() {
        APIManager.shared.getContent(name: postNames) { [self] posts in
            DispatchQueue.main.async {
                guard let view = viewInput else { return }
                view.configureTableView(posts: posts)
                view.animatedAlpha()
            }
        }
    }
    
    func like(index: Int, likes: Int) {
        let post = postNames[index]
        APIManager.shared.liked(post: post, likes: likes)
    }
    
    func unlike(index: Int, likes: Int) {
        let post = postNames[index]
        APIManager.shared.unliked(post: post, likes: likes)
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
