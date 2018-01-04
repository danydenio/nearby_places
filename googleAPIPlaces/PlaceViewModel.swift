//
//  PlaceViewModel.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation
import UIKit
class PlaceViewModel {
    let id: String
    let networkManager = NetworkManager()
    var place: Place?
    var marks: [Mark]?
    var image: UIImage?
    
    init(id: String) {
        self.id = id
    }    
    func getPlace(completition: @escaping() -> Void) {        
        networkManager.performPlaceSearch(id: self.id) { [unowned self] (result) in
            if let place = result?.one {
                self.place = place
            }
            completition()
        }
    }
    func getImage(completition: @escaping() -> Void) {
        guard let photos = self.place?.photos, let photoReference = photos.first?.photo_reference else { return }
        networkManager.loadImage(reference: photoReference) { [weak self] (image) in
            self?.image = image
            completition()
        }
    }
}
