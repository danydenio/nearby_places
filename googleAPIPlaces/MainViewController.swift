//
//  ViewController.swift
//  googleAPIPlaces
//
//  Created by mobile consulting on 1/3/18.
//  Copyright © 2018 daniel. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

class MainViewController: UIViewController {
    @IBOutlet weak var mapKit: MKMapView!
    let locationManager = CLLocationManager()
    let viewModel = ViewModel()
    var selectedId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCoreLocation()
        setupMapKit()
        //setUpPlaces()
    }
    fileprivate func setupMapKit() {
        mapKit.delegate = self
    }
    fileprivate func setUpCoreLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func setUpPlaces() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                viewModel.getPlaces { [weak self] in
                    self?.addAnotations()
                }
            }
        } else {
            print("Location services are not enabled")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.placeSegueIdentifier {
            if let controller = segue.destination as? PlaceViewController, let identifier = selectedId {
                controller.id = identifier
            }
        }
    }
}

// -- MARK CLLocationManager
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.last else {
            return
        }
        centerMapOnLocation(location, mapView: mapKit)
        setUpPlaces()
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapKit.showsUserLocation = true
            setUpPlaces()
        }
    }
}

// -- MARK MKMapViewDelegate
extension MainViewController: MKMapViewDelegate {
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    fileprivate func addAnotations() {
        if let marks = self.viewModel.marks {
            mapKit.addAnnotations(marks)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("I have beein clicked")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Mark else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? Mark else {
            return
        }
        selectedId = annotation.identifier
        performSegue(withIdentifier: Constants.placeSegueIdentifier, sender: nil)
    }
}


