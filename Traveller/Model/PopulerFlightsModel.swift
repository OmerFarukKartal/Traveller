//
//  HomePageModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 18.03.2024.
//

import Foundation
// MARK: - PopularFlight
struct PopularFlights: Decodable {
    let id, airlineID: Int?
    let airlineName: String?
    let airlineImage: String?
    let airportID: Int?
    let airportName: String?
    let adultSeatPrice, childPrice, infantPrice, duration: Int
    let departureTime, arrivalTime: String?
    let baggage, cabinBaggage, flightTypeID: Int?
    let flightTypeName, departureCity, landingCity: String?
    let available: Bool?
}


