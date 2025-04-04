import Foundation

var accessToken: String {
    return UserDefaults.standard.string(forKey: "accessToken") ?? ""
}

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }

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
    case getPopularHotels
    case getPopularTour
    case getAirportList
    case getHotelList
    case getFlightSearch(airportId: Int, landingCity: String)
    case getSelectedFlight(id: String)
    case getHotelWithLocation(locationId: Int)
    case getHotelRoomWithId(hotelId: Int)
    case getRoomWithId(roomId:Int)
    case getHotelWithId(hotelId: Int)
    case getBlogWithId(blogId: Int)
    case getTourWithId(tourId: Int)
    case getTourTypeList
    case getTourSerach(typeid: Int)
    case flightReservationPay
    case hotelReservationPay
    case tourReservationPay
    case createFlightReservation(name: String, surname: String, phone: String, email: String, flightId: Int, age: String)
    case createHotelReservation(hotelRoomId: Int, checkInDate: String, checkOutDate: String)
    case createTourReservation(tourID: Int, person: Int)
    case allBlog
    case getFlightTicket
    case getHotelReservation
    case getTourReservation
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return "https://www.finalproject.com.tr/api"
    }
    
    var path: String {
        switch self {
        case .getAirLineList: return "/Airline/AirlineList"
        case .register: return "/Registers/CreateUser"
        case .getPopularFlights: return "/Flights/GetFeaturedFlights"
        case .getPopularHotels: return "/Hotels/Get5Hotel"
        case .getAirportList: return "/Airport/AirportList"
        case .getHotelList: return "/Locations/GetAllLocations"
        case .getFlightSearch: return "/FlightReserve/GetFlightsByAirport"
        case .getHotelRoomWithId: return "/FilterHotelRooms/GetHotelRoomsByHotelID"
        case .getSelectedFlight(let id): return "/Flights/GetFlight/\(id)"
        case .getHotelWithLocation: return "/FilterHotels/GetHotelsByLocation"
        case .getHotelWithId(let Id): return "/Hotels/GetHotel/\(Id)"
        case .getBlogWithId(let Id): return "/Blogs/GetBlog/\(Id)"
        case .getRoomWithId(let roomId): return "/HotelRooms/GettHotelRoomById/\(roomId)"
        case .getPopularTour: return "/Tours/GetPopularTours"
        case .getTourTypeList: return "/TourType/TourTypeList"
        case .getTourSerach(let typeid): return "/FilterTours/GetToursByTourtype"
        case .getTourWithId(let tourId): return "/Tours/GetTour/\(tourId)"
        case .flightReservationPay: return "/Payment/Checkout"
        case .hotelReservationPay: return "/Payment/HotelCheckout"
        case .tourReservationPay: return "/Payment/TourCheckout"
        case .createFlightReservation: return "/FlightReservations/CreateFlightReservation"
        case .allBlog: return "/Blogs/BlogList"
        case .createHotelReservation: return "/HotelReservation/CreateHotelReservation"
        case .createTourReservation: return "/TourReservation/CreateTourReservation"
        case .getFlightTicket: return "/FlightReservations/GetMyFlightReservations"
        case .getHotelReservation:  return "/HotelReservation/GetMyReservations"
        case .getTourReservation: return "/TourReservation/GetMyTourReservations"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAirLineList, .getPopularFlights, .getPopularHotels, .getAirportList, .getTourWithId, .allBlog, .getTourTypeList, .getPopularTour, .getHotelList, .getFlightSearch, .getHotelWithLocation, .getFlightTicket, .getHotelReservation, .getTourReservation, .getSelectedFlight, .getHotelRoomWithId, .getTourSerach, .getHotelWithId,.getBlogWithId, .getRoomWithId:
            return .get
        case .register, .createFlightReservation, .createHotelReservation, .createTourReservation:
            return .post
        case .flightReservationPay, .hotelReservationPay, .tourReservationPay: return .post
        }
    }
    
    var headers: [String: String]? {
        let defaultHeaders = ["Content-type": "application/json; charset=UTF-8"]
        
        switch self {
        case .flightReservationPay,.createTourReservation, .hotelReservationPay, .tourReservationPay, .createFlightReservation, .createHotelReservation, .getFlightTicket, .getHotelReservation, .getTourReservation:
            return [
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": "Bearer \(accessToken)"
            ]
        default:
            break
        }
        
        return defaultHeaders
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAirLineList, .getPopularFlights, .getPopularHotels, .getAirportList, .getTourWithId, .getHotelRoomWithId, .getTourSerach, .getHotelList, .getTourTypeList, .getPopularTour, .getFlightSearch, .allBlog, .getHotelWithLocation, .getSelectedFlight, .getHotelWithId, .getBlogWithId, .getRoomWithId, .flightReservationPay, .hotelReservationPay, .tourReservationPay, .getFlightTicket, .getHotelReservation, .getTourReservation:
            return nil
        case .register(let username, let password, let name, let surname, let email):
            return [
                "username": username,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email
            ]
        case .createFlightReservation(let name, let surname, let phone, let email, let flightId, let age):
            return [
                "name": name,
                "surname": surname,
                "phone": phone,
                "email": email,
                "flightId": flightId,
                "age": age,
            ]
        case .createHotelReservation(let hotelRoomId, let checkInDate, let checkOutDate):
            return [
                "hotelRoomId": hotelRoomId,
                "checkInDate": checkInDate,
                "checkOutDate": checkOutDate
            ]
        case .createTourReservation(let tourID, let person):
            return [
                "tourID": tourID,
                "person": person
            ]
        }
    }
    
    func request() -> URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path += path
        
        switch self {
        case .getFlightSearch(let airportId, let landingCity):
            components.queryItems = [
                URLQueryItem(name: "airportid", value: "\(airportId)"),
                URLQueryItem(name: "landingcity", value: landingCity)
            ]
        case .getHotelWithLocation(let locationId):
            components.queryItems = [
                URLQueryItem(name: "locationid", value: "\(locationId)")
            ]
        case .getHotelRoomWithId(let hotelId):
            components.queryItems = [URLQueryItem(name: "hotelid", value: "\(hotelId)")]
            
        case .getTourSerach(let typeid):
            components.queryItems = [
                URLQueryItem(name: "tourtypeid", value: "\(typeid)")]
        default:
            break
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return request
    }
}
