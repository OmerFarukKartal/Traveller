class HotelViewModel {
    var popularHotels: [PopularHotels] = []
    var hotels: [HotelWithLocationId] = []
    var hotelReservations: [HotelReservation] = []
    var rooms: [HotelRoom] = []
    var reservationRoom:[HotelRoom] = []
    var searchDetailResult: [HotelWithId] = []
    var errorMessage: String = ""
    let networkManager = NetworkManager.shared
    var searchResult: [HotelWithLocationId] = []
    static let shared = HotelViewModel()

    func getPopularHotels(completion: @escaping () -> Void) {
        networkManager.getPopulerHotels { result in
            switch result {
            case .success(let popularHotels):
                self.popularHotels = popularHotels
                completion()
            case .failure(let error):
                print("Error fetching popular hotels: \(error.localizedDescription)")
            }
        }
    }

    func getHotelList(completion: @escaping ([[String]]) -> Void) {
        networkManager.getHotelList { result in
            switch result {
            case .success(let hotels):
                var hotelData: [[String]] = []
                for hotel in hotels {
                    if let name = hotel.name, let id = hotel.id {
                        let idString = String(id)
                        hotelData.append([name, idString])
                    }
                }
                completion(hotelData)
            case .failure(let error):
                print("Error fetching hotel list: \(error.localizedDescription)")
            }
        }
    }

    func getSelectedHotel(id: Int, completion: @escaping (Result<HotelWithId, Error>) -> Void) {
        networkManager.getHotelWithId(hotelId: id) { result in
            switch result {
            case .success(let hotelDetail):
                completion(.success(hotelDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchHotel(locationId: Int, completion: @escaping () -> Void) {
        networkManager.getHotelWithLocation(locationId: locationId) { result in
            switch result {
            case .success(let hotels):
                self.hotels = hotels
                completion()
            case .failure(let error):
                print("Error searching hotels: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                completion()
            }
        }
    }
    
    func getHotelRoom(hotelId: Int, completion: @escaping () -> Void) {
        networkManager.getHotelRoomWithId(hotelId: hotelId) { result in
            switch result {
            case .success(let rooms):
                self.rooms = rooms
                completion()
            case .failure(let error):
                print("Error searching room\(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                completion()
            }
        }
    }
    func createHotelReservation(hotelRoomId: Int, checkInDate: String, checkOutDate: String, completion: @escaping(Result<RegisterResponse, Error>) -> Void) {
        networkManager.hotelCreateReservation(hotelRoomId: hotelRoomId, checkInDate: checkInDate, checkOutDate: checkOutDate) { result in
            completion(result)
        }
    }
    
    func getHotelReservation(completion: @escaping () -> Void) {
        networkManager.getHotelReservation { result in
            switch result {
            case .success(let hotelReservations):
                self.hotelReservations = hotelReservations
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
