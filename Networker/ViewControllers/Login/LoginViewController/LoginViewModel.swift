//
//  LoginViewModel.swift
//  Networker
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation

protocol LoginViewInput {
    
}

protocol LoginViewOutput: Coordinating {
    
}

class LoginViewModel: LoginViewOutput {
    var coordinator: Coordinator?
}
