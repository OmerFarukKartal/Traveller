//
//  HotelRoomModle.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 27.05.2024.
//

import Foundation

// MARK: - HotelRoom
struct HotelRoom: Decodable {
    let hotelRoomID, roomPrice: Int?
    let roomNumber, roomType: String?
    let roomImage: String?
    let hotelID: Int?
}
