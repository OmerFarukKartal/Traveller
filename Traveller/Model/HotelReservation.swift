//
//  HotelReservation.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 8.06.2024.
//

import Foundation

struct HotelReservation: Decodable {
    let hotelReservationID: Int
    let hotelRoomId: Int?
    let checkInDate: String
    let checkOutDate: String
    let status: String
    let totalPrice: Double?
    let username: String
}
