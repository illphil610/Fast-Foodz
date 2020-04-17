//
//  YelpDataModels.swift
//  Fast Foodz
//
//  Created by Phil on 4/15/20.
//

import Foundation

struct YelpBusinessModel: Codable {
    var businesses: [BusinessModel]?
}

struct Location: Codable {
    var address1: String? = ""
    var address2: String? = ""
    var address3: String? = ""
    var zip_code: String? = ""
    var state: String? = ""
    var city: String? = ""
}

struct Coordinates: Codable {
    var latitude: Double? = 0.0
    var longitude: Double? = 0.0
}

struct Category: Codable {
    var alias: String? = ""
    var title: String? = ""
}

struct BusinessModel: Codable {
    var coordinates: Coordinates
    var categories: [Category]
    var location: Location
    var image_url: String? = ""
    var distance: Double? = 0.0
    var rating: Double? = 0.0
    var price: String? = ""
    var phone: String? = ""
    var name: String? = ""
    var url: String? = ""
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
