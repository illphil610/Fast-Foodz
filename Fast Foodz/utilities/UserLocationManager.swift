//
//  LocationManager.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import Foundation
import MapKit

class UserLocationManager: NSObject {
    
    // MARK: Properties
        
    static let shared = UserLocationManager()
    
    fileprivate let locationManager = CLLocationManager()
    
    fileprivate lazy var currentLocation: CLLocationCoordinate2D? = {
        self.locationManager.location?.coordinate
    }()
            
    // MARK: Initialization
    
    fileprivate override init() {
        super.init()
        
        setupLocationManager()
    }
    
}

fileprivate extension UserLocationManager {
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func presentAlertShowingLocationServiceIsNeeded() {
    }
}

extension UserLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // well be back
        print("locations \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error \(error)")
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            presentAlertShowingLocationServiceIsNeeded()
        case .authorizedWhenInUse, .authorizedAlways:
            guard CLLocationManager.locationServicesEnabled() else { presentAlertShowingLocationServiceIsNeeded(); return }
        @unknown default: break
        }
    }
    
}


