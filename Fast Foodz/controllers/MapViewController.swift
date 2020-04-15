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
    
    lazy var locationManager = { CLLocationManager() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServiceAuthStatus()
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // well be back
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // well be back
    }
    
}

fileprivate extension MapViewController {
    
    // MARK: Location Methods
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServiceAuthStatus() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // show alert telling the user to enable lcoation services
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alert to turn off parentl controls, etc. if possible
            break
        case .denied:
            // show alert to instruct user how to enable location
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            //centerViewOnUserLocation()
            break
        @unknown default:
            break
        }
    }
    
    func centerViewOnUserLocation() {
        guard let location = locationManager.location?.coordinate else { return }
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
}
