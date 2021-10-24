//
//  APIManager.swift
//  Networker
//
//  Created by Misha Causur on 24.10.2021.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class APIManager {
    
    static let shared = APIManager()
    
    private func configureFirebase() -> Firestore {
        var datebase: Firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        datebase = Firestore.firestore()
        return datebase
    }
    
    func getPosts(postID: String, contentID: String, completion: @escaping (Post?)->() ) {
        let database = configureFirebase()
        database.collection("posts").document(postID).getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
        }
    }
    
    func getImageForPost(contentID: String, completion: @escaping (UIImage?)->() ) {
        let storage = Storage.storage()
    }
}
