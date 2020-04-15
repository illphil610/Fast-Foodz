//
//  HomeViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var mapViewController: UIView!
    @IBOutlet weak var listViewController: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControlTextAttributes()
    }
    
    // MARK: Actions
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(
                withDuration: 0.5, animations: {
                    self.mapViewController.alpha = 1
                    self.listViewController.alpha = 0
                }
            )
        case 1:
            UIView.animate(
                withDuration: 0.5, animations: {
                    self.mapViewController.alpha = 0
                    self.listViewController.alpha = 1
                }
            )
        default: break
        }
    }

}

fileprivate extension HomeViewController {
    
    // MARK: Segmented Control
    
    func setupSegmentedControlTextAttributes() {
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.deepIndigo], for: UIControl.State.normal
        )
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    // MARK: Location Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("coords \(String(describing: locationManager.location?.coordinate))")
//        print("location \(String(describing: locations.last?.coordinate))")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: break
            //locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted: break
            //presentAlertShowingLocationServiceIsNeeded()
        case .authorizedWhenInUse, .authorizedAlways:
            guard CLLocationManager.locationServicesEnabled() else {
                //presentAlertShowingLocationServiceIsNeeded()
                return
            }
            //centerViewOnUserLocation()
        @unknown default: break
        }
    }
    
}


