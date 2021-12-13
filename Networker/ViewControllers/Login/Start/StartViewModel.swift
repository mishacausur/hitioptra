//
//  StartViewModel.swift
//  Networker
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation

protocol StartViewInput {
    
}

protocol StartViewOutput: Coordinating {
    
}

class StartViewModel: StartViewOutput {
    var coordinator: Coordinator?
}
