//
//  ConfirmationViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation

protocol ConfirmationViewInput: AnyObject {
    
}

protocol ConfirmationViewOutput {
    
    func verify(code: String, completion: @escaping (Bool)->())
    
}

class ConfirmationViewModel: ConfirmationViewOutput {
    
    
    weak var viewInput: ConfirmationViewInput?
    
    var coordinator: AppCoordinator?
    
    func verify(code: String, completion: @escaping (Bool)->()) {
       
        AuthManager.shared.verifyAuth(code: code) { value in
            guard value else {
                print("CODE IS \(code)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
}
