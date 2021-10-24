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
    let text: String
    let image: UIImage?
    let likes: Int
    let comments: Int
}
