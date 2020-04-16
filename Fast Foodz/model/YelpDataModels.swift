//
//  YelpDataModels.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import Foundation

struct YelpBusinessModel: Codable {
    let businesses: [BusinessModel]
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct Location: Codable {
    let address1: String
    let address2: String?
    let address3: String?
    let zip_code: String
    let state: String
    let city: String
}

struct BusinessModel: Codable {
    let coordinates: Coordinates
    let location: Location
    let image_url: String
    let phone: String
    let name: String
    let url: String
}
