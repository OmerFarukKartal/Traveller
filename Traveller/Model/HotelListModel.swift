//
//  HotelListModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 13.05.2024.
//

import Foundation

struct HotelList: Decodable {
    let id: Int?
    let name, description: String?
    let stars, rating, locationID: Int?
    let locationName, checkin, checkout, hotemlAmentities: String?
    let policy, cancellation: String?
    let ageRequirement, price, currencyID: Int?
    let currencyName, image: String?
}

struct HotelLocaiton: Decodable {
    let id: Int?
    let name: String?
}

