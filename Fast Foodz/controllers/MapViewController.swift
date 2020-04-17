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
    
    fileprivate let reuseIdentifier = "AnnotationView"
    fileprivate let initialSpanInMeters: Double = 1000
    
    fileprivate lazy var impactGenerator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .medium)
    }()
    
    // MARK: Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    func centerViewOnUser(_ location: CLLocation) {
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: initialSpanInMeters,
            longitudinalMeters: initialSpanInMeters
        )
        
        mapView.setRegion(region, animated: false)
    }
    
    func placeAnnotationPinsOnMap(with yelpBusinessModels: [BusinessModel]) {
        yelpBusinessModels.forEach { [weak self] business in
            
            let annotation = YelpBusinessMapAnnotation(for: business)
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: business.coordinates.latitude,
                longitude: business.coordinates.longitude
            )
            
            self?.mapView.addAnnotation(annotation)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    // MARK: MapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        annotationView.image = UIImage(named: "pin")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !(view.annotation is MKUserLocation) else { return }
        impactGenerator.prepare()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            impactGenerator.impactOccurred()
            
            // pass the details VC the data for the business to present
            let yelpMapAnnotation = view.annotation as? YelpBusinessMapAnnotation
            
            detailsVC.updateViewsWithBusinessData(for: yelpMapAnnotation?.business)
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
    }
    
}

fileprivate extension MapViewController {
    
    // MARK: Yelp Map Annotation
    class YelpBusinessMapAnnotation: MKPointAnnotation {
        let business: BusinessModel
        
        init(for business: BusinessModel) {
            self.business = business
        }
    }
}

