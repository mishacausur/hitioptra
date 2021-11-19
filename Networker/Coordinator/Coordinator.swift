//
//  AppCoordinator.swift
//  Networker
//
//  Created by Misha Causur on 16.10.2021.
//

import Foundation
import UIKit


protocol Coordinator {
    
    var navigationViewController: UINavigationController? { get set }
    func eventOccurred(with type: Event, with string: String?)
}

protocol Coordinating {
    
    var coordinator: Coordinator? { get set }
}
