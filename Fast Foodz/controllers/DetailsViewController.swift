//
//  DetailsViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import MapKit
import SwiftLocation
import Kingfisher

class DetailsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callButton: UIButton!
    
    fileprivate var currentBusiness: BusinessModel?
        
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupCallButton()
        createDirectionRequest()
    }
    
    func updateViewsWithBusinessData(for business: BusinessModel?) {
        let imageUrl = URL(string: business?.image_url ?? "")
        currentBusiness = business

        DispatchQueue.main.async {
            self.imageView?.kf.setImage(with: imageUrl)
            self.label?.text = business?.name
            self.mapView?.centerCoordinate.latitude = business?.coordinates.latitude ?? 0.0
            self.mapView?.centerCoordinate.longitude = business?.coordinates.longitude ?? 0.0
        }
    }
    
    // MARK: Actions
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func callBusinessButtonTapped(_ sender: UIButton) {
        
    }
    
}

extension DetailsViewController: MKMapViewDelegate {
    
    // MARK: MapViewDelegate
        
    fileprivate func createDirectionRequest() {
        let sourceCoordinates = mapView.userLocation.location?.coordinate ??  UserLocationManager.defaultLocation.coordinate
        let destinationCoordinates = CLLocationCoordinate2D(
            latitude: currentBusiness?.coordinates.latitude ?? 0.0,
            longitude: currentBusiness?.coordinates.longitude ?? 0.0
        )
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: { response, error in
            guard let response = response else {
                if let error = error {
                    print("[DetailsVC] Error getting directions: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let mapRect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(mapRect), animated: true)
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.bluCepheus
        renderer.lineWidth = 4.0
        return renderer
    }
    
}

fileprivate extension DetailsViewController {
    
    // MARK: Private Methods
    
    func setupMapView() {
        mapView.delegate = self
        mapView.layer.cornerRadius = 12
        mapView.clipsToBounds = true
    }
    
    func setupCallButton() {
        callButton.layer.cornerRadius = 6
        callButton.clipsToBounds = true
    }
    
}
