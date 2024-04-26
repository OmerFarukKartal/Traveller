//
//  Endpoint.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 18.03.2024.
//

import Foundation
import UIKit

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var headers: [String: String]? {get}
    var parameters: [String: Any]? {get}
    
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case getAirLineList
    case register(username: String, password: String, name: String, surname: String, email: String)
    case getPopularFlights
    case getPopulerHotels
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
    return "https://www.finalproject.com.tr/api"
    }
    
    var path: String {
        switch self {
        case .getAirLineList: return "/Airline/AirlineList"
            
        case .register:     return "/Registers/CreateUser"
        case .getPopularFlights:    return "/Flights/GetFeaturedFlights"
        case .getPopulerHotels:     return "/Hotels/Get5Hotel"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAirLineList, .getPopularFlights, .getPopulerHotels:     return .get
        case .register:     return .post

        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getAirLineList, .getPopularFlights, .getPopulerHotels:   return nil
        case .register(let username, let password, let name, let surname, let email):
            return [
                "username": username,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email
            ]
        }
    }
    
    func request() -> URLRequest {
        guard let components = URLComponents(string: baseURL),
              let url = components.url?.appendingPathComponent(path) else {
            fatalError("URL HATASI")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }catch {
                print(error.localizedDescription)
            }
        }
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
