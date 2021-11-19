//
//  ProfileViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation

protocol ProfileViewInput: AnyObject {
    func configureProfile(profile: ProfileData)
}

protocol ProfileViewOutput {
    func getProfile()
}

class ProfileViewModel: ProfileViewOutput {
    
    weak var viewInput: ProfileViewInput?
    
    var coordinator: Coordinator?
    
    func getProfile() {
        APIManager.shared.getProfile(profileID: "Mishutto") { [unowned self] profile in
            guard let profile = profile else { return }
            print(profile)
            viewInput?.configureProfile(profile: profile)
        }
    }
    
}
