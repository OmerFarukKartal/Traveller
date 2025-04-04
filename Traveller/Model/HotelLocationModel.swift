//
//  HotelLocationModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 21.05.2024.
//

import Foundation
struct HotelWithLocationId: Decodable {
    let id: Int?
    let name, description: String?
    let stars, rating, locationID: Int?
    let locationName, checkin, checkout, hotemlAmentities: String?
    let policy, cancellation: String?
    let ageRequirement, price, currencyID: Int?
    let currencyName: String?
    let image: String?
}
