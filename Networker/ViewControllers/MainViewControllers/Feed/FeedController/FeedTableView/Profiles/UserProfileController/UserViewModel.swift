//
//  UserViewModel.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import UIKit

protocol UserViewInput: AnyObject {
    func configureViewWithData(profile: ProfileData, posts: [Post])
}

protocol UserViewOutput {
    func like(index: Int, likes: Int)
    func unlike(index: Int, likes: Int)
    func getProfile()
}

class UserViewModel: UserViewOutput {
    
    weak var viewInput: UserViewInput?
    
    var coordinator: AppCoordinator?
    
    var author: String
    
    init(author: String) {
        self.author = author
    }
    
    func like(index: Int, likes: Int) {
        let post = "post\(index)"
        APIManager.shared.liked(post: post, likes: likes)
    }
    
    func unlike(index: Int, likes: Int) {
        let post = "post\(index)"
        APIManager.shared.unliked(post: post, likes: likes)
    }
    
    func getProfile() {
        APIManager.shared.getProfile(profileID: author) { profile in
            guard let profile = profile else { return }
            
            APIManager.shared.getContent(name: profile.posts) { posts in
                self.viewInput?.configureViewWithData(profile: profile, posts: posts)
                
            }
        }
    }
}
