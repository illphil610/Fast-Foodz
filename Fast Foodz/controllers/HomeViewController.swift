//
//  HomeViewController.swift
//  Fast Foodz
//
//  Created by Phil on 4/14/20.
//

import UIKit


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
    
    func setupSegmentedControlTextAttributes() {
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.deepIndigo], for: UIControl.State.normal
        )
    }
    
}
