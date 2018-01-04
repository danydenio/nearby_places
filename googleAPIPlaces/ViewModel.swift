//
//  ViewModel.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    let networkManager = NetworkManager()
    var marks: [Mark]?
    
    func getPlaces(completition: @escaping() -> Void) {
        networkManager.performPlacesSearch { [unowned self] marksResult in
            self.marks = marksResult
            completition()
        }
    }
}
