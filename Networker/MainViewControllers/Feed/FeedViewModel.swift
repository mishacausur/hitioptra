//
//  FeedViewModel.swift
//  Networker
//
//  Created by Misha Causur on 18.10.2021.
//

import Foundation

protocol FeedViewInput: AnyObject {
    
}

protocol FeedViewOutput {
    
    
}

class FeedViewModel: FeedViewOutput {
    
    weak var viewInput: FeedViewInput?
}
