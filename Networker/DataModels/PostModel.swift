//
//  PostModel.swift
//  Networker
//
//  Created by Misha Causur on 20.10.2021.
//

import Foundation
import UIKit

struct Post {
    let author: String
    let type: String
    let date: Int
    let id: Int
    let text: String
    let image: UIImage?
    var likes: Int
    var isLiked: Bool
    let comments: Int
}
