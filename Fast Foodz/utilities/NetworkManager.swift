//
//  NetworkManager.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import Foundation
import CoreLocation
import Alamofire

class NetworkManager {
        
    static func fetchJsonFromYelpApiService(for location: CLLocation, completion: @escaping ([BusinessModel]?) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(yelpAPIKey)",
        ]
        
        let params: [String: Any] = [
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude,
            "radius": 1000,
            "sort_by": "distance",
            "categories": "pizza, mexican, chinese, burgers"
        ]

        AF.request(baseYelpApiUrl, parameters: params, headers: headers).responseJSON { response in
            let yelpBusinessModel = try? JSONDecoder().decode(YelpBusinessModel.self, from: response.data ?? Data())
            completion(yelpBusinessModel?.businesses)
        }
    }
    
}

fileprivate extension NetworkManager {
    
}
