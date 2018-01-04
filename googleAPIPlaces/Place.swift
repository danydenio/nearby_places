//
//  Place.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

struct Place: Codable {
    let id: String
    let name: String
    let address: String
    let telephone: String?
    var rating: Double?
    let website: URL?
    var reviews: [Review]?
    var photos: [Photo]?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address = "formatted_address"
        case telephone = "international_phone_number"
        case rating
        case website
        case reviews
        case photos
    }
}

