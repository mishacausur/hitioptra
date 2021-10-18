//
//  AuthManager.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private var veryficationID: String?
    
    func startAuth(phone: String, completion: @escaping (Bool)->()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { [weak self] veryficationID, error in
            guard let veryficationID = veryficationID, error == nil else {
                completion(false)
                return
            }
            self?.veryficationID = veryficationID
            completion(true)
            
        }
    }
    
    func verifyAuth(code: String, completion: @escaping (Bool)->()) {
        guard let veryficationID = veryficationID else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: veryficationID, verificationCode: code)
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
