//
//  TourReservation.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 9.06.2024.
//

import Foundation

// MARK: - TourReservation
struct TourReservation: Decodable {
    let id: Int
    let tourID: Int
    let tourName: String
    let totalPrice: Double
    let person: Int
    let status: String
}
