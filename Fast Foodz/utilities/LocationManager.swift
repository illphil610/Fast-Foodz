//
//  LocationManager.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: Properties
    
    static let shared = LocationManager()
    
    lazy var locationManager = { CLLocationManager() }()
    
    override init() {
        super.init()
        
        checkLocationServiceAuthStatus()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationServiceAuthStatus() {
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
            // show alert to turn off parentl controls, etc if possible
            break
        case .denied:
            // show alert to instruct user how to enable location
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            // do map stuff
            break
        @unknown default:
            break
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // well be back
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // well be back
    }
    
}


