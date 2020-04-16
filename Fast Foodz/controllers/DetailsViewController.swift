//
//  DetailsViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import MapKit

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
    
    // MARK: Actions
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func callBusinessButtonTapped(_ sender: UIButton) {
        
    }
    

}
