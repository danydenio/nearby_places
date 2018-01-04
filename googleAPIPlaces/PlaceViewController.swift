//
//  PlaceViewController.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {
    var place: Place?
    var id: String?
    var viewModel: PlaceViewModel?
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelAddress: UILabel!
    @IBOutlet private weak var labelTelephone: UILabel!
    @IBOutlet private weak var labelReview: UILabel!
    @IBOutlet private weak var labelReviewCount: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelWebSite: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id {
            viewModel = PlaceViewModel(id: id)
            initViewModel()
        }
    }
    func initViewModel() {
        viewModel?.getPlace { [weak self] in
            print("Done")
            self?.labelName.text = self?.viewModel?.place?.name
            self?.labelAddress.text = self?.viewModel?.place?.address
            self?.labelTelephone.text = self?.viewModel?.place?.telephone ?? "No telephone"
            if let rating = self?.viewModel?.place?.rating {
                self?.labelReview.text = String(format:"%.2f", rating)
            } else {
                self?.labelReview.text = "No rating"
            }
            if let website = self?.viewModel?.place?.website {
                self?.labelWebSite.text = website.relativeString
            } else {
                self?.labelWebSite.text = "No website"
            }
            self?.viewModel?.getImage {
                if let image = self?.viewModel?.image {
                    self?.imageView.image = image
                }
                
            }
        }
    }
}
