class FlightViewModel {
    var selectedDepartureAirportId: String?
    var selectedLandingAirport: String?
    var popularFlights: [PopularFlights] = []
    var searchResults: [FlightSearchResult] = [] // Arama sonuçlarını tutacak bir dizi
    var flightTicket: [FlightTicketModel] = []
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
    
    func getAirportList(completion: @escaping ([[String]]) -> Void) {
        networkManager.getAirportList { result in
            switch result {
            case .success(let success):
                var airports: [[String]] = []
                success.forEach{ airport in
                    if let name = airport.name, let id = airport.id {
                        let idString = String(id)
                        airports.append([name, idString])
                    }
                }
                completion(airports)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func searchFlight(airportid: Int, landingCity: String, completion: @escaping () -> Void) {
        networkManager.getFlightSearch(airportId: airportid, landingCity: landingCity) { result in
            switch result {
            case .success(let success):
                self.searchResults = success
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getSelectedFlight(id: String, completion: @escaping (Result<FlightSearchResult, Error>) -> Void) {
        networkManager.getSelectedFlight(Id: id) { result in
            switch result {
            case .success(let flight):
                completion(.success(flight))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func crateFlightReservation(name: String, surname: String, phone: String, email: String, flightId: Int, age: String, completion: @escaping(Result<RegisterResponse, Error>) -> Void) {
        networkManager.flightCreateReservation(name: name, surname: surname, email: email, phone: phone, age: age, flightId: flightId) { result in
            completion(result)
        }
    }
    func getFlightTicket(completion: @escaping () -> Void) {
        networkManager.getFlightTicket { result in
            switch result {
            case .success(let flightTicket):
                self.flightTicket = flightTicket
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
