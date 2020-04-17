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
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var callButton: UIButton!
    fileprivate var currentBusiness: BusinessModel?
        
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
        guard let url = URL(string: currentBusiness?.url ?? "") else { return }
        
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @IBAction func callBusinessButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: "tel://(\(currentBusiness?.phone ?? "")"), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url)
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
            guard let response = response else { return }
            
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
    
    func setupViews() {
        setupMapViewAndMakeDirectionsRequest()
        setupCallButton()
    }
    
    func setupMapViewAndMakeDirectionsRequest() {
        mapView.delegate = self
        mapView.layer.cornerRadius = 12
        mapView.clipsToBounds = true
        createDirectionRequest()
    }
    
    func setupCallButton() {
        callButton.layer.cornerRadius = 6
        callButton.clipsToBounds = true
    }
    
}
