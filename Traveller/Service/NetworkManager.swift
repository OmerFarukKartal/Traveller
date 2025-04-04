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
                    completion(.failure(NSError(domain: "Invalid Response", code: 0, userInfo: nil)))
                    return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "Invalid Data", code: 0, userInfo: nil)))
                    print("Invalid Data")
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
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
        let endpoint = Endpoint.getPopularHotels
        request(endpoint, completion: completion)
    }

    func getAirportList(completion: @escaping(Result<[AirportList], Error>) -> Void) {
        let endpoint = Endpoint.getAirportList
        request(endpoint, completion: completion)
    }

    func getHotelList(completion: @escaping(Result<[HotelLocaiton], Error>) -> Void) {
        let endpoint = Endpoint.getHotelList
        request(endpoint, completion: completion)
    }
    
    func getFlightSearch(airportId: Int, landingCity: String, completion: @escaping(Result<[FlightSearchResult], Error>) -> Void){
        let endpoint = Endpoint.getFlightSearch(airportId: airportId, landingCity: landingCity)
        request(endpoint, completion: completion)
    }
    
    func getSelectedFlight(Id: String, completion: @escaping(Result<FlightSearchResult, Error>) ->Void ) {
        let endpoint = Endpoint.getSelectedFlight(id: Id)
        request(endpoint, completion: completion)
    }
    
    func getHotelWithLocation(locationId: Int, completion: @escaping(Result<[HotelWithLocationId], Error>) -> Void) {
        let endpoint = Endpoint.getHotelWithLocation(locationId: locationId)
        request(endpoint, completion: completion)
    }
    
    func getHotelWithId(hotelId: Int, completion: @escaping (Result<HotelWithId, Error>) -> Void) {
        let endpoint = Endpoint.getHotelWithId(hotelId: hotelId)
        request(endpoint, completion: completion)
    }
    
    func getPopulerTours(completion: @escaping(Result<[PopularTour], Error>) -> Void) {
        let endpoint = Endpoint.getPopularTour
        request(endpoint, completion: completion)
    }
    
    func getTourTypeList(completion: @escaping(Result<[TourType], Error>) -> Void) {
        let endpoint = Endpoint.getTourTypeList
        request(endpoint, completion: completion)
    }
    
    func getTourSearch(typeid: Int, completion: @escaping(Result<[TourWithId], Error>) -> Void){
        let endpoint = Endpoint.getTourSerach(typeid: typeid)
        request(endpoint, completion: completion)
    }
    
    func getTourWihID(tourId: Int, completion: @escaping(Result<TourWithId, Error>) -> Void) {
        let endpoint = Endpoint.getTourWithId(tourId: tourId)
        request(endpoint, completion: completion)
    }
    
    func getHotelRoomWithId(hotelId: Int, completion: @escaping (Result<[HotelRoom], Error>) -> Void) {
        let endpoint = Endpoint.getHotelRoomWithId(hotelId: hotelId)
        request(endpoint, completion: completion)
    }

    func flightReservationPay(completion: @escaping(Result<ReservationResponse,Error>) -> Void) {
        let endpoint = Endpoint.flightReservationPay
        request(endpoint, completion: completion)
    }
    func flightCreateReservation(name: String, surname: String, email: String, phone: String, age: String, flightId: Int, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        let endpoint = Endpoint.createFlightReservation(name: name, surname: surname, phone: phone, email: email, flightId: flightId, age: age)
        request(endpoint, completion: completion)
    }
    func getAllBlogList(completion: @escaping(Result<[BlogList], Error>) -> Void) {
        let endpoint = Endpoint.allBlog
        request(endpoint, completion: completion)
    }
    func hotelCreateReservation(hotelRoomId: Int, checkInDate: String, checkOutDate: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        let endpoint = Endpoint.createHotelReservation(hotelRoomId: hotelRoomId, checkInDate: checkInDate, checkOutDate: checkOutDate)
        request(endpoint, completion: completion)
    }
    func hotelReservationPay(completion: @escaping(Result<ReservationResponse,Error>) -> Void) {
        let endpoint = Endpoint.hotelReservationPay
        request(endpoint, completion: completion)
    }
    func getFlightTicket(completion: @escaping(Result<[FlightTicketModel], Error>) -> Void) {
        let endpoint = Endpoint.getFlightTicket
        request(endpoint, completion: completion)
    }
    func createTourReservation(tourID: Int, person: Int, completion: @escaping(Result<RegisterResponse, Error>) -> Void) {
        let endpoint = Endpoint.createTourReservation(tourID: tourID, person: person)
        request(endpoint, completion: completion)
    }
    func tourReservationPay(completion: @escaping(Result<ReservationResponse,Error>) -> Void) {
        let endpoint = Endpoint.tourReservationPay
        request(endpoint, completion: completion)
    }
    func getHotelReservation(completion: @escaping(Result<[HotelReservation], Error>) -> Void) {
        let endpoint = Endpoint.getHotelReservation
        request(endpoint, completion: completion)
    }
    func getTourReservation(completion: @escaping(Result<[TourReservation], Error>) -> Void) {
        let endpoint = Endpoint.getTourReservation
        request(endpoint, completion: completion)
    }
    func getBlogWithId(blogId: Int, completion: @escaping (Result<BlogList, Error>) -> Void) {
        let endpoint = Endpoint.getBlogWithId(blogId: blogId)
        request(endpoint, completion: completion)
    }

}
