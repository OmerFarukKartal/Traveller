//
//  Tour.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.05.2024.
//

import Foundation

// MARK: - PopularTour
struct PopularTour: Decodable {
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

struct TourType: Decodable {
    let id: Int?
    let name: String?
}

struct Tour: Decodable {
    let id: Int?
    let name: String
    let currencyId: Int
    let currencyName: String
    let stars: Int
    let rating: Int
    let tourAdultPrice: Int
    let tourChildPrice: Int
    let description: String
    let policy: String
    let location: String
    let tourTypeId: Int
    let tourTypeName: String
    let image: String
}

