//
//  UserProfile.swift
//  Networker
//
//  Created by Misha Causur on 20.10.2021.
//

import Foundation
import UIKit

struct UserProfile {
    
    let id: Int
    var userName: String
    var name: String
    var surname: String
    var image: UIImage
    var isOnline: Bool
    var posts: [Post] = []
    var following: [UserProfile] = []
    var followers: [UserProfile] = []
    
}

let user = UserProfile(id: 1, userName: "JD", name: "DJD", surname: "KDKDK", image: UIImage(named: "ava")!, isOnline: true)
let user2 = UserProfile(id: 1, userName: "JD", name: "DJD", surname: "KDKDK", image: UIImage(named: "person")!, isOnline: true)
let user3 = UserProfile(id: 1, userName: "JD", name: "DJD", surname: "KDKDK", image: UIImage(named: "cosmo")!, isOnline: true)

class users {

    static let users: [UserProfile] = [user,user2,user3,user,user,user,user]

}
