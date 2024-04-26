//
//  Services.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 18.03.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Invalid Response. Status Code: \(httpResponse.statusCode)")
                    } else {
                        print("Invalid Response")
                    }
                    completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "Invalid Data", code: 0)))
                    print("Invalid Data")
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    print(decodedData)
                    completion(.success(decodedData))
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
        
    func register(username: String, password: String, name: String, surname: String ,email: String, completion: @escaping(Result<RegisterResponse,Error>) -> Void) {
        let endpoint = Endpoint.register(username: username, password: password, name: name, surname: surname,email: email )
        request(endpoint, completion: completion)
    }
    
    func getPopularFlights(completion: @escaping(Result<[PopularFlights], Error>) -> Void) {
        let endpoint = Endpoint.getPopularFlights
        request(endpoint, completion: completion)
    }
    
    func getPopulerHotels(completion: @escaping(Result<[PopularHotels], Error>) -> Void) {
        let endpoint = Endpoint.getPopulerHotels
        request(endpoint, completion: completion)
    }
}
