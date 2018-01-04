//
//  GMSPlaceLikelihoodList+ConvertToPlaces.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation
import GooglePlaces

extension GMSPlaceLikelihoodList {
    func convertToMarks() -> [Mark] {
        var marks = [Mark]()
        for mark in self.likelihoods {
            marks.append(mark.convertToMark())
        }
        return marks
    }
}
