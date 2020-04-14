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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
    }
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
               case 0:
                   UIView.animate(withDuration: 0.5, animations: {
                       self.mapViewController.alpha = 1
                       self.listViewController.alpha = 0
                   })
               case 1:
                   UIView.animate(withDuration: 0.5, animations: {
                       self.mapViewController.alpha = 0
                       self.listViewController.alpha = 1
                   })
               default: break
               }
        
    }

}
