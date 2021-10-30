//
//  UserViewModel.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation

protocol UserViewInput: AnyObject {
    
    func configureViewWithData(profile: ProfileData)
}

protocol UserViewOutput {
    
    func getProfile()
}

class UserViewModel: UserViewOutput {
    
    weak var viewInput: UserViewInput?
    
    var coordinator: AppCoordinator?
    
    var author: String
    
    init(author: String) {
        self.author = author
    }
    
    func getProfile() {
        APIManager.shared.getProfile(profileID: author) { profile in
            guard let profile = profile else { return }
            self.viewInput?.configureViewWithData(profile: profile)
        }
    }
}
