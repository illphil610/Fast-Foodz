//
//  UserLocationManager.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import Foundation
import SwiftLocation
import CoreLocation

class UserLocationManager {
    static func getUsersLocation(completion: @escaping (CLLocation) -> Void) {
        LocationManager.shared.locateFromGPS(.oneShot, accuracy: .block) { result in
            switch result {
            case .success(let location):
                completion(location)
            case .failure(_):
                completion(CLLocation(latitude: 40.758896, longitude: -73.985130))
            }
        }
    }
    
}
