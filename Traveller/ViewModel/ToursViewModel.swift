//
//  Tours.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.05.2024.
//

import Foundation

class ToursViewModel {
    
    var popularTours: [PopularTour] = []
    var errorMessage: String = ""
    var searchResult: [TourWithId] = []
    let networkManager = NetworkManager.shared
    var tourReservation: [TourReservation] = []
    static let shared = ToursViewModel()
    var tourId: Int?
    
    func getPopularTours(completion: @escaping () -> Void) {
        networkManager.getPopulerTours { result in
            switch result {
            case .success(let popularTours):
                self.popularTours = popularTours
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTourTypeList(completion: @escaping ([[String]]) -> Void ) {
        networkManager.getTourTypeList { result in
            switch result {
            case .success(let success):
                var tourTypes: [[String]] = []
                success.forEach { tourType in
                    if let name = tourType.name, let id = tourType.id {
                        let idString = String(id)
                        tourTypes.append([name, idString])
                    }
                }
                completion(tourTypes)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func searchTour(typeid: Int, completion: @escaping () -> Void) {
        networkManager.getTourSearch(typeid: typeid) { result in
            switch result {
            case .success(let success):
                self.searchResult = success
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func getSelectedTour(id: Int, completion: @escaping(Result<TourWithId, Error>) -> Void) {
        networkManager.getTourWihID(tourId: id) { result in
            switch result {
            case .success(let tours):
                completion(.success(tours))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createTourReservation(tourID: Int, person: Int, completion: @escaping(Result<RegisterResponse, Error>) -> Void) {
        networkManager.createTourReservation(tourID: tourID, person: person) { result in
            completion(result)
        }
    }
    func getTourReservation(completion: @escaping () -> Void) {
        networkManager.getTourReservation { result in
            switch result {
            case .success(let tour):
                self.tourReservation = tour
                completion()
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
}

