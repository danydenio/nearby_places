//
//  NetworkManager.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation
import GooglePlaces
import Alamofire
import AlamofireImage

struct OneHolder<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case one = "result"
    }
    let one: T
}

class NetworkManager {
    lazy var placesClient = GMSPlacesClient()
    init() {
        GMSPlacesClient.provideAPIKey(Constants.googlePlacesAPIKEY)
    }
    func performPlacesSearch(completition: @escaping ([Mark]?) -> Void) {
        placesClient =  GMSPlacesClient.shared()
        placesClient.currentPlace { (places, error) in
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                completition(nil)
            }
            guard let placesQuery = places else {
                completition(nil)
                return
            }
            completition(placesQuery.convertToMarks())
        }
    }
    internal func performPlaceSearch(id: String, completition: @escaping (OneHolder<Place>?) -> Void) {
        let parameters: Parameters = ["placeid": id, "key": Constants.googlePlacesAPIKEY]
        Alamofire.request("https://maps.googleapis.com/maps/api/place/details/json", method: .get, parameters: parameters).responseData { (response) in
            print(response)
            if response.result.isFailure {
                completition(nil)
                return
            }
            guard let jsonData = response.result.value else {
                completition(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(OneHolder<Place>.self, from: jsonData)
                completition(result)
            } catch let error {
                print("Error")
                print(error)
            }
            
        }
    }
    func loadImage(reference: String, completition: @escaping (Image?) -> Void) {
        let parameters: Parameters = ["maxwidth": "300","photoreference": reference, "key": Constants.googlePlacesAPIKEY]
        Alamofire.request("https://maps.googleapis.com/maps/api/place/photo", parameters: parameters).responseImage { response in
            if response.result.isFailure {
                completition(nil)
                return
            }
            print(response)
            if let image = response.result.value {
                completition(image)
            }
            else {
                completition(nil)
            }
        }
    }
}
