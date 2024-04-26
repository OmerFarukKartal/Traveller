//  HomePageViewModel.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 18.03.2024.

import Foundation

class FlightViewModel {
    var popularFlights: [PopularFlights] = []
    
    var errorMessage: String = ""
    let networkManager = NetworkManager.shared
    static let shared = FlightViewModel()
    
    func getPopularFlights(completion: @escaping () -> Void) {
        networkManager.getPopularFlights { result in
            switch result {
            case .success(let popularFlights):
                self.popularFlights = popularFlights
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
