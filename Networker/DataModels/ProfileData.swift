//
//  ProfileData.swift
//  Networker
//
//  Created by Misha Causur on 30.10.2021.
//

import Foundation
import UIKit

struct ProfileData {
    
    let name: String
    let type: String
    let postsCount: Int
    let followers: Int
    let followings: Int
    let photos: Int
    let posts: [String]
    
    static let mishutto = ProfileData(name: "Mishutto", type: "Частное лицо", postsCount: 0, followers: 27, followings: 36, photos: 8, posts: [])
}
