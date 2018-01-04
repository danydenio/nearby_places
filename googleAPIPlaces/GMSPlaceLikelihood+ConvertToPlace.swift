//
//  GMSPlaceLikelihood+ConvertToPlace.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation
import GooglePlaces

extension GMSPlaceLikelihood {
    func convertToMark() -> Mark {
        return Mark(identifier: self.place.placeID, title: self.place.name, coordinate: self.place.coordinate)
    }    
}
