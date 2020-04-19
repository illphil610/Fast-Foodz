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
        
        mapView.setRegion(region, animated: true)
    }
    
    func placeAnnotationPinsOnMap(with yelpBusinessModels: [BusinessModel]) {
        yelpBusinessModels.forEach { [weak self] business in
            
            let annotation = YelpBusinessMapAnnotation(for: business)
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: business.coordinates.latitude ?? 0.0,
                longitude: business.coordinates.longitude ?? 0.0
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapPinTapped(_:)))
        annotationView.addGestureRecognizer(tapGestureRecognizer)
        annotationView.isUserInteractionEnabled = true
        annotationView.image = UIImage(named: FastFoodzConstants.pin)
        return annotationView
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
    
    @objc func mapPinTapped(_ sender: UITapGestureRecognizer?) {
        guard
            let mapAnnotationView = sender?.view as? MKAnnotationView,
            !(mapAnnotationView.annotation is MKUserLocation) else { return }
        
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
        
        let storyboard = UIStoryboard(name: FastFoodzConstants.storyboardMain, bundle: Bundle.main)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: FastFoodzConstants.detailsVC) as? DetailsViewController {
            let yelpMapAnnotation = mapAnnotationView.annotation as? YelpBusinessMapAnnotation
            DispatchQueue.main.async {
                detailsVC.updateViewsWithBusinessData(for: yelpMapAnnotation?.business)
                self.navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }
}

