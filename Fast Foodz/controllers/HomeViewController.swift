//
//  HomeViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var listViewContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var mapViewController: MapViewController?
    fileprivate var listViewController: ListViewController?
        
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControlTextAttributes()
        getUsersLocationAndCenterOnMap()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentVC = segue.destination as? MapViewController, segue.identifier == "MapEmbedSegue" {
            mapViewController = currentVC
        } else if let currentVC = segue.destination as? ListViewController, segue.identifier == "ListEmbedSeque" {
            listViewController = currentVC
        }
    }

}

fileprivate extension HomeViewController {
    
    // MARK: Segmented Control UI
    
    func setupSegmentedControlTextAttributes() {
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.deepIndigo], for: UIControl.State.normal
        )
    }
    
    // MARK: Segment Control Actions
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(
                withDuration: 0.5, animations: {
                    self.mapViewContainer.alpha = 1
                    self.listViewContainer.alpha = 0
                }
            )
        case 1:
            UIView.animate(
                withDuration: 0.5, animations: {
                    self.mapViewContainer.alpha = 0
                    self.listViewContainer.alpha = 1
                }
            )
        default: break
        }
    }
    
    // MARK: Location
    
    func handleStartingActivityIndicatorAndHidingContainerViews() {
        self.mapViewContainer.alpha = 0
        self.listViewContainer.alpha = 0
        activityIndicator.startAnimating()
    }
    
    func getUsersLocationAndCenterOnMap() {
        handleStartingActivityIndicatorAndHidingContainerViews()
        
        UserLocationManager.getUsersLocation(completion: { [weak self] location in
            self?.mapViewController?.centerViewOnUser(location)
            
            NetworkManager.fetchJsonFromYelpApiService(for: location, completion: { [weak self] businesses in
                guard let businesses = businesses else { return }
                                
                self?.mapViewController?.placeAnnotationPinsOnMap(with: businesses)
                //give the businesses to the listview controller to display the data
            
                self?.activityIndicator.stopAnimating()
                self?.mapViewContainer.alpha = 1
                self?.listViewContainer.alpha = 1
            })
        })
    }
    
}


