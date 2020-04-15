//
//  MapUtility.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import UIKit

class MapUtility {
    
    static func getAlertForLocationAccessIfNeeded() -> UIAlertController {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Location Access",
            message: "Location access is required for including the location of the fast foodz.",
            preferredStyle: UIAlertController.Style.alert
        )
    
        alert.addAction(
            UIAlertAction(title: "Allow Location Access", style: .cancel, handler: { alert -> Void in
                UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
            })
        )
        alert.addAction(
            // if they cancel this... use default jawn
            UIAlertAction(title: "Cancel", style: .default, handler: nil)
        )
        
        return alert
    }
}
