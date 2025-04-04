//
//  TourWithTypeId.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.05.2024.
//

import Foundation
struct TourWithId: Decodable {
    let id: Int?
    let name: String?
    let currencyID: Int?
    let currencyName: String
    let stars, rating, tourAdultPrice, tourChildPrice: Int
    let description, policy, location: String?
    let tourTypeID: Int?
    let tourTypeName: String?
    let image: String?
}
