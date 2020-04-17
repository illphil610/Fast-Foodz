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
        
        getUsersLocationAndYelpData()
        setUpSegmentControlAndCheckSelectedState()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentVC = segue.destination as? MapViewController, segue.identifier == FastFoodzStringConstants.mapEmbedSeque {
            mapViewController = currentVC
        } else if let currentVC = segue.destination as? ListViewController, segue.identifier == FastFoodzStringConstants.listEmbedSeque {
            listViewController = currentVC
        }
    }

}

fileprivate extension HomeViewController {
    
    // MARK: Location / Yelp API Request
    
    func getUsersLocationAndYelpData() {
        handleStartingActivityIndicatorAndHidingContainerViews()
        
        UserLocationManager.getUsersLocation(completion: { [weak self] location in
            self?.mapViewController?.centerViewOnUser(location)
            
            NetworkManager.fetchJsonFromYelpApiService(for: location, completion: { [weak self] businesses in
                guard let businessModels = businesses else {
                    self?.handleEndingActivityIndicatorAndShowingErrorAlert(); return
                }
                
                self?.passBusinessModelsToViewControllers(businessModels)
               self?.handleEndingActivityIndicatorAndPresentingContainerViews()
            })
        })
    }
    
    // MARK: Segmented Control
    
    func setUpSegmentControlAndCheckSelectedState() {
        checkSegmentControlStateAtLaunch()
        setupSegmentedControl()
    }
    
    func checkSegmentControlStateAtLaunch() {
        guard let value = UserDefaults.standard.value(forKey: FastFoodzStringConstants.segmentControlSelection) as? Int else { return }
        segmentedControl.selectedSegmentIndex = value
        handleContainerTransition()
    }
    
    func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.deepIndigo], for: UIControl.State.normal
        )
    }
    
    // MARK: Segment Control Actions
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(
            sender.selectedSegmentIndex,
            forKey: FastFoodzStringConstants.segmentControlSelection
        )
        
        handleContainerTransition()
    }
    
    func handleStartingActivityIndicatorAndHidingContainerViews() {
        activityIndicator.startAnimating()
        mapViewContainer.alpha = 0
        listViewContainer.alpha = 0
        segmentedControl.alpha = 0
    }
    
    func handleEndingActivityIndicatorAndPresentingContainerViews() {
        activityIndicator.stopAnimating()
        segmentedControl.alpha = 1
        handleContainerTransition()
    }
        
    func handleEndingActivityIndicatorAndShowingErrorAlert() {
        activityIndicator.stopAnimating(); mapViewContainer.alpha = 0
        
        let alert = UIAlertController(title: "No data available",
                                   message: "We ran into an issue retreiving your data",
                                   preferredStyle: .alert)
        // Create the actions
        let retryAction = UIAlertAction(title: "Retry", style: .default) { UIAlertAction in
            self.getUsersLocationAndYelpData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func passBusinessModelsToViewControllers(_ businessModels: [BusinessModel]) {
        mapViewController?.placeAnnotationPinsOnMap(with: businessModels)
        listViewController?.yelpBusinessData = businessModels
    }
    
    func handleContainerTransition() {
        switch segmentedControl.selectedSegmentIndex {
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
    
}


