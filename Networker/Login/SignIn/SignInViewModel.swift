//
//  SignInViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation

protocol SignInViewInput: AnyObject {
    
}

protocol SignInViewOutput {
    
    func auth(phone: String, completion: @escaping (Bool)->())
    
}

class SignInViewModel: SignInViewOutput {
    
    
    weak var viewInput: SignInViewInput?
    
    var coordinator: AppCoordinator?
    
    func auth(phone: String, completion: @escaping (Bool)->()) {
        let number = "+7 \(phone)"
        AuthManager.shared.startAuth(phone: number) { value in
            guard value else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
}
