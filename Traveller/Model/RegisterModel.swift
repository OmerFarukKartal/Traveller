//
//  RegisterModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 2.04.2024.
//

import Foundation

struct RegisterModel: Decodable {
    let username: String?
    let password: String?
    let name: String?
    let surname: String?
    let email: String?
}
