//
//  Review.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

struct  Review: Codable {
    let authorName: String?
    let text: String?
    let rating: Double?
    
    enum codingKeys: String, CodingKey {
        case authorName = "author_name"
        case text
        case rating        
    }
}
