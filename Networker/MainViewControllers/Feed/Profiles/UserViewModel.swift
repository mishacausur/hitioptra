//
//  UserViewModel.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import UIKit

protocol UserViewInput: AnyObject {
    var photos: [UIImage] { get set }
    func configureViewWithData(profile: ProfileData)
    func buildPhotoCollectionWithPhotos(photos: [UIImage])
}

protocol UserViewOutput {
    var photos: [UIImage] { get }
    
    func getProfile()
    func getPhotos()
}

class UserViewModel: UserViewOutput {
    
    weak var viewInput: UserViewInput?
    
    var coordinator: AppCoordinator?
    
    var author: String
    
    let photosIndex = ["1","2","3","4","5","6"]
    
    var photos: [UIImage] = [] {
        didSet {
            viewInput?.photos = self.photos
        }
    }
    
    init(author: String) {
        self.author = author
    }
    
    func getProfile() {
        APIManager.shared.getProfile(profileID: author) { profile in
            guard let profile = profile else { return }
            self.viewInput?.configureViewWithData(profile: profile)
        }
    }
    
    func getPhotos() {
        APIManager.shared.getttt(id: photosIndex) { pics in
            DispatchQueue.main.async {
                self.photos = pics
            }
            
        }
        
    }
}
