//
//  DetailsViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import MapKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callButton: UIButton!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.layer.cornerRadius = 12
        mapView.clipsToBounds = true
        
        callButton.layer.cornerRadius = 6
        callButton.clipsToBounds = true
       
    }
    
    func updateViewsWithBusinessData(for business: BusinessModel?) {
        
        let imageUrl = URL(string: business?.image_url ?? "")

        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: imageUrl)
            self.label.text = business?.name
            self.mapView.centerCoordinate.latitude = business?.coordinates.latitude ?? 0.0
            self.mapView.centerCoordinate.longitude = business?.coordinates.longitude ?? 0.0
        }
    }
    
    // MARK: Actions
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func callBusinessButtonTapped(_ sender: UIButton) {
        
    }
    

}
