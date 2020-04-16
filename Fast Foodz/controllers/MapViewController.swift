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
    
    @IBOutlet weak var mapView: MKMapView!
    let reuseIdentifier = "AnnotationView"
    let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    func centerViewOnUser(_ location: CLLocation) {
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: false)
    }
    
    func placeAnnotationPinsOnMap(with yelpBusinessModels: [BusinessModel]) {
        yelpBusinessModels.forEach { [weak self] business in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: business.coordinates.latitude,
                longitude: business.coordinates.longitude
            )
            self?.mapView.addAnnotation(annotation)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if annotationView == nil { annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier) }
        annotationView?.image = UIImage(named: "pin")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            // pass the details VC the data for the business to present
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}

