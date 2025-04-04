
import Foundation


class PayViewModel {
    var url: String = ""
    var hotelurl: String = ""
    var toururl: String = ""
    let networkManager = NetworkManager.shared
    var errorMessage: String = ""
    
    func loadPaymentURL(completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.flightReservationPay { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.url = response.url
                    completion(.success(response.url))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    func loadHotelPaymentURL(completion: @escaping (Result<String, Error>) -> Void) {
        networkManager.hotelReservationPay { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.hotelurl = response.url
                    completion(.success(response.url))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    func loadTourPaymentURL(completion: @escaping (Result<String, Error>) -> Void) {
        networkManager.tourReservationPay { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.toururl = response.url
                    completion(.success(response.url))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}



