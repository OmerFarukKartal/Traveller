//
//  searchFlightModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 20.05.2024.
//

import Foundation

struct FlightSearchResult: Decodable {
    let flightId: Int?
    let airlineID: Int
    let airlineName: String
    let airportID: Int
    let airportName: String
    let adultSeatPrice: Double
    let childPrice: Double
    let infantPrice: Double
    let duration: Int
    let departureTime: String
    let arrivalTime: String
    let baggage: Int
    let cabinBaggage: Int
    let flightTypeID: Int
    let flightTypeName: String
    let departureCity: String
    let landingCity: String
    let airlineImage: String
}

