//
//  PopulerHotelsModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 12.05.2024.
//

import Foundation

// MARK: - PopularHotel
struct PopularHotels: Decodable {
    let id: Int?
    let name, description: String?
    let stars, rating, locationID: Int?
    let locationName, checkin, checkout, hotemlAmentities: String?
    let policy, cancellation: String?
    let ageRequirement, price, currencyID: Int
    let currencyName, image: String
}
