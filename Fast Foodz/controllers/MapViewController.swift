//
//  MapViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet fileprivate weak var mapView: MKMapView!
    
    fileprivate let locationManager = CLLocationManager()
    
    lazy var currentLocation: CLLocationCoordinate2D? = {
        self.locationManager.location?.coordinate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }

}

fileprivate extension MapViewController {
        
    // MARK: Private Location Methods
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        //locationManager.requestLocation()
    }
    
    func centerViewOnUserLocation() {
        guard let location = locationManager.location?.coordinate else { return }
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func presentAlertShowingLocationServiceIsNeeded() {
        present(MapUtility.getAlertForLocationAccessIfNeeded(), animated: true, completion: nil)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    // MARK: Location Delegate Methods
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("coords \(String(describing: locationManager.location?.coordinate))")
//        print("location \(String(describing: locations.last?.coordinate))")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
//        print("error \(error)")
//    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            presentAlertShowingLocationServiceIsNeeded()
        case .authorizedWhenInUse, .authorizedAlways:
            guard CLLocationManager.locationServicesEnabled() else { presentAlertShowingLocationServiceIsNeeded(); return }
            centerViewOnUserLocation()
        @unknown default: break
        }
    }
}
