//
//  Photos.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/4/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let photo_reference: String
    
    enum codingKeys: String, CodingKey {
        case photo_reference = "photo_reference"
    }
}
