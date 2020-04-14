//
//  MapViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultlLocation = CLLocation(latitude: 40.758896, longitude: -73.985130)
        mapView.centerToLocation(defaultlLocation)
    }

}

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion (
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
      setRegion(coordinateRegion, animated: true)
    }
}
