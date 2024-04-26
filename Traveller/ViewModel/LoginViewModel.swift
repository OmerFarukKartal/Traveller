//
//  LoginViewModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.03.2024.
//

struct LoginResponse: Decodable {
    
    let token: String?
    let expireDate: String?
    
}

struct RegisterResponse: Decodable {
    let message: String
}

