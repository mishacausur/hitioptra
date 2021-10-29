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
    
    func getContent(name: [String], completion: @escaping ([Post])->() ) {
        var posts: [Post] = []
        name.forEach { value in
            self.getPosts(postID: value, contentID: value) { post in
                guard post != nil else {
                    completion(posts)
                    return }
                posts.append(post!)
                completion(posts)
            }
        }
    }
    
    func liked(post: String, likes: Int) {
        let database = configureFirebase()
        let doc = database.collection("posts").document(post)
        doc.updateData(["isLiked" : true, "likes": likes]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func unliked(post: String, likes: Int) {
        let database = configureFirebase()
        let doc = database.collection("posts").document(post)
        doc.updateData(["isLiked" : false, "likes": likes]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func getPosts(postID: String, contentID: String, completion: @escaping (Post?)->() ) {
        let database = configureFirebase()
        database.collection("posts").document(postID).getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
            self.getImageForPost(contentID: contentID) { image in
                let post = Post(author: document?.get("author") as! String, type: document?.get("type") as! String, date: document?.get("date") as! Int, id: document?.get("id") as! Int, text: document?.get("text") as! String, image: image, likes: document?.get("likes") as! Int, isLiked: document?.get("isLiked") as! Bool, comments: document?.get("comments") as! Int)
                completion(post)
            }
        }
    }
    
    func getImageForPost(contentID: String, completion: @escaping (UIImage?)->() ) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let path = reference.child("pictures")
        var image: UIImage = UIImage(named: "imageDownloadErrorMessage")!
        let file = path.child(contentID + ".jpg")
        file.getData(maxSize: 1024*1024) { data, error in
            guard error == nil else {
                completion(image)
                return
            }
            guard let data = data, let dataImage = UIImage(data: data) else { return }
            image = dataImage
            completion(image)
        }
    }
}
