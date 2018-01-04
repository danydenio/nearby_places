//
//  ArtWork.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation
import MapKit

class Mark: NSObject, MKAnnotation {
    let identifier: String
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(identifier: String, title: String, coordinate: CLLocationCoordinate2D) {
        self.identifier = identifier
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
}
