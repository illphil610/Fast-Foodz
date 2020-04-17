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

struct Location: Codable {
    let address1: String
    let address2: String?
    let address3: String?
    let zip_code: String
    let state: String
    let city: String
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double    
}

struct Category: Codable {
    let alias: String
    let title: String
}

struct BusinessModel: Codable {
    let coordinates: Coordinates
    let categories: [Category]
    let location: Location
    let image_url: String
    let distance: Double
    let rating: Double
    let price: String?
    let phone: String
    let name: String
    let url: String
}

struct FastFoodzStringConstants {
    static let yelpBusinessTableViewCell = "YelpBusinessTableViewCell"
    static let segmentControlSelection = "segmentControlSelection"
    static let detailsVC = "DetailsViewController"
    static let listEmbedSeque = "ListEmbedSeque"
    static let mapEmbedSeque = "MapEmbedSegue"
    static let storyboardMain = "Main"
    static let ratingDollars = "$$$$"
    static let pin = "pin"
}
