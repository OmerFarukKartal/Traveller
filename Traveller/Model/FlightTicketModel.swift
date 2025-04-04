//
//  FlightTicketModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 8.06.2024.
//

import Foundation

struct FlightTicketModel: Decodable {
    let flightReservationID: Int
    let name: String
    let surname: String
    let email: String
    let phone: String
    let flightID: Int
    let age: Int
    let status: String
    let totalPrice: Double
    let departureCity: String
    let landingCity: String
}
