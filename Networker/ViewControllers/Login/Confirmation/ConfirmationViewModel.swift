//
//  ConfirmationViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation

protocol ConfirmationViewInput: AnyObject {
    
}

protocol ConfirmationViewOutput: Coordinating {
    
    func verify(code: String, completion: @escaping (Bool)->())
    
}

class ConfirmationViewModel: ConfirmationViewOutput {
    
    weak var viewInput: ConfirmationViewInput?
    
    var coordinator: Coordinator?
    
    func verify(code: String, completion: @escaping (Bool)->()) {
       
        AuthManager.shared.verifyAuth(code: code) { value in
            guard value else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
}
