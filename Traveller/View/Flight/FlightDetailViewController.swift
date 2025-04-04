import UIKit
import Kingfisher

class FlightDetailViewController: UIViewController {
    var flightID: Int?
    let viewModel = FlightViewModel.shared
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let airlineNameLabel = UILabel()
    let departureCityLabel = UILabel()
    let landingCityLabel = UILabel()
    let durationInfoLabel = UILabel()
    let arrivelTimeInfoLabel = UILabel()
    let departureTimeInfoLabel = UILabel()
    // ImageView tanımı
    let flightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arriveFlight") // "arriveFlight" adında bir resim dosyası olduğunu varsayıyorum
        return imageView
    }()
    
    let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arriveTime2") // "arriveFlight" adında bir resim dosyası olduğunu varsayıyorum
        return imageView
    }()
    
    let passengerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "passenger") // "arriveFlight" adında bir resim dosyası olduğunu varsayıyorum
        return imageView
    }()
    
    let departureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kalkış Şehri:"
        return label
    }()
    
    let yetiskinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Yetişkin Yolcu (+12 yaş):"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let yetiskinPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let cocukLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cocuk Yolcu (7-12 yaş):"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let cocukPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let bebekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bebek Yolcu (0-7 yaş):"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let bebekPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let havaYoluLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hava Yolu Şirketi:"
        return label
    }()
    
    let seçimLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lütfen Seçim Yapınız"
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uçuş Süresi:"
        return label
    }()
    
    let kalkisSaatiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kalkış Zamanı:"
        return label
    }()
    
    let varisSaatiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Varış Zamanı:"
        return label
    }()
    
    let landingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Varış Şehri:"
        return label
    }()
    
    let ucusBilgiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uçuş Bilgileri"
        return label
    }()
    
    let reservationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Rezervasyon Oluştur  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(reservationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchFlightDetails()
        self.navigationItem.title = ""
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Title StackView
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(ucusBilgiLabel)
        ucusBilgiLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.35, paddingRight: screenWidth * 0.35)
        view.addSubview(havaYoluLabel)
        havaYoluLabel.anchor(top: ucusBilgiLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05)
        view.addSubview(airlineNameLabel)
        airlineNameLabel.anchor(top: ucusBilgiLabel.bottomAnchor, left: havaYoluLabel.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.02)
        
        // Container View
        let firstContainerView = UIView()
        firstContainerView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.layer.borderWidth = 1.0
        firstContainerView.layer.cornerRadius = 8
        firstContainerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(firstContainerView)
        firstContainerView.anchor(top: airlineNameLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02, paddingRight: screenWidth * 0.02, height: screenHeight * 0.20)
        
        let departureStackView = UIStackView()
        departureStackView.axis = .horizontal
        departureStackView.spacing = screenWidth * 0.03
        departureStackView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.addSubview(departureStackView)
        
        departureStackView.addArrangedSubview(departureLabel)
        departureStackView.addArrangedSubview(departureCityLabel)
        departureStackView.anchor(top: firstContainerView.topAnchor, left: firstContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        
        // Altına çizgi ekle
        let departureSeparatorView = UIView()
        departureSeparatorView.backgroundColor = .black
        firstContainerView.addSubview(departureSeparatorView)
        departureSeparatorView.anchor(top: departureStackView.bottomAnchor, left: firstContainerView.leftAnchor, right: firstContainerView.rightAnchor, paddingTop: 4,paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let durationStackView = UIStackView()
        durationStackView.axis = .horizontal
        durationStackView.spacing = screenWidth * 0.03
        durationStackView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.addSubview(durationStackView)
        
        durationStackView.addArrangedSubview(durationLabel)
        durationStackView.addArrangedSubview(durationInfoLabel)
        durationStackView.anchor(top: departureSeparatorView.bottomAnchor, left: firstContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        // Altına çizgi ekle
        let durationSeparatorView = UIView()
        durationSeparatorView.backgroundColor = .black
        firstContainerView.addSubview(durationSeparatorView)
        durationSeparatorView.anchor(top: durationStackView.bottomAnchor, left: firstContainerView.leftAnchor, right: firstContainerView.rightAnchor, paddingTop: 4, paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let landingStackView = UIStackView()
        landingStackView.axis = .horizontal
        landingStackView.spacing = screenWidth * 0.04
        landingStackView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.addSubview(landingStackView)
        
        landingStackView.addArrangedSubview(landingLabel)
        landingStackView.addArrangedSubview(landingCityLabel)
        landingStackView.anchor(top: durationSeparatorView.bottomAnchor, left: firstContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        // Altına çizgi ekle
        let landingSeparatorView = UIView()
        landingSeparatorView.backgroundColor = .black
        firstContainerView.addSubview(landingSeparatorView)
        landingSeparatorView.anchor(top: landingStackView.bottomAnchor, left: firstContainerView.leftAnchor, right: firstContainerView.rightAnchor, paddingTop: 4, paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let imageStackView = UIStackView()
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.addSubview(imageStackView)
        imageStackView.addArrangedSubview(flightImageView)
        
        imageStackView.anchor(top: firstContainerView.topAnchor, left: firstContainerView.leftAnchor, right: firstContainerView.rightAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.7, paddingRight: screenWidth * 0.03, height: screenHeight * 0.15 )
        
        let secondContainerView = UIView()
        secondContainerView.translatesAutoresizingMaskIntoConstraints = false
        secondContainerView.layer.borderWidth = 1.0
        secondContainerView.layer.cornerRadius = 8
        secondContainerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(secondContainerView)
        secondContainerView.anchor(top: firstContainerView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02, paddingRight: screenWidth * 0.02, height: screenHeight * 0.14)
        
        let departureTimeStackView = UIStackView()
        departureTimeStackView.axis = .horizontal
        departureTimeStackView.spacing = screenWidth * 0.03
        departureTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        secondContainerView.addSubview(departureTimeStackView)
        
        departureTimeStackView.addArrangedSubview(kalkisSaatiLabel)
        departureTimeStackView.addArrangedSubview(departureTimeInfoLabel)
        departureTimeStackView.anchor(top: secondContainerView.topAnchor, left: secondContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        let departureTimeSeparatorView = UIView()
        departureTimeSeparatorView.backgroundColor = .black
        secondContainerView.addSubview(departureTimeSeparatorView)
        departureTimeSeparatorView.anchor(top: departureTimeStackView.bottomAnchor, left: secondContainerView.leftAnchor, right: secondContainerView.rightAnchor, paddingTop: 4,paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let landingTimeStackView = UIStackView()
        landingTimeStackView.axis = .horizontal
        landingTimeStackView.spacing = screenWidth * 0.04
        landingTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        secondContainerView.addSubview(landingTimeStackView)
        
        landingTimeStackView.addArrangedSubview(varisSaatiLabel)
        landingTimeStackView.addArrangedSubview(arrivelTimeInfoLabel)
        landingTimeStackView.anchor(top: departureTimeSeparatorView.bottomAnchor, left: secondContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        let landingTimeSeparatorView = UIView()
        landingTimeSeparatorView.backgroundColor = .black
        secondContainerView.addSubview(landingTimeSeparatorView)
        landingTimeSeparatorView.anchor(top: landingTimeStackView.bottomAnchor, left: secondContainerView.leftAnchor, right: secondContainerView.rightAnchor, paddingTop: 4, paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let imageTimeStackView = UIStackView()
        imageTimeStackView.translatesAutoresizingMaskIntoConstraints = false
        secondContainerView.addSubview(imageTimeStackView)
        imageTimeStackView.addArrangedSubview(timeImageView)
        
        imageTimeStackView.anchor(top: secondContainerView.topAnchor, left: secondContainerView.leftAnchor, right: secondContainerView.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.7, paddingRight: screenWidth * 0.03, height: screenHeight * 0.1 )
        
        
        let thirdContainerView = UIView()
        thirdContainerView.translatesAutoresizingMaskIntoConstraints = false
        thirdContainerView.layer.borderWidth = 1.0
        thirdContainerView.layer.cornerRadius = 8
        thirdContainerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(thirdContainerView)
        thirdContainerView.anchor(top: secondContainerView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02, paddingRight: screenWidth * 0.02, height: screenHeight * 0.21)
        
        let yetiskinStackView = UIStackView()
        yetiskinStackView.axis = .horizontal
        yetiskinStackView.spacing = screenWidth * 0.03
        yetiskinStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdContainerView.addSubview(yetiskinStackView)
        
        yetiskinStackView.addArrangedSubview(yetiskinLabel)
        yetiskinStackView.addArrangedSubview(yetiskinPriceLabel)
        yetiskinStackView.anchor(top: thirdContainerView.topAnchor, left: thirdContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        let yetiskinStackViewSeparatorView = UIView()
        yetiskinStackViewSeparatorView.backgroundColor = .black
        thirdContainerView.addSubview(yetiskinStackViewSeparatorView)
        yetiskinStackViewSeparatorView.anchor(top: yetiskinStackView.bottomAnchor, left: thirdContainerView.leftAnchor, right: thirdContainerView.rightAnchor, paddingTop: 4,paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let cocukStackView = UIStackView()
        cocukStackView.axis = .horizontal
        cocukStackView.spacing = screenWidth * 0.04
        cocukStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdContainerView.addSubview(cocukStackView)
        
        cocukStackView.addArrangedSubview(cocukLabel)
        cocukStackView.addArrangedSubview(cocukPriceLabel)
        cocukStackView.anchor(top: yetiskinStackViewSeparatorView.bottomAnchor, left: thirdContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        let cocukSeparatorView = UIView()
        cocukSeparatorView.backgroundColor = .black
        thirdContainerView.addSubview(cocukSeparatorView)
        cocukSeparatorView.anchor(top: cocukStackView.bottomAnchor, left: thirdContainerView.leftAnchor, right: thirdContainerView.rightAnchor, paddingTop: 4, paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let bebekStackView = UIStackView()
        bebekStackView.axis = .horizontal
        bebekStackView.spacing = screenWidth * 0.04
        bebekStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdContainerView.addSubview(bebekStackView)
        bebekStackView.addArrangedSubview(bebekLabel)
        bebekStackView.addArrangedSubview(bebekPriceLabel)
        bebekStackView.anchor(top: cocukSeparatorView.bottomAnchor, left: thirdContainerView.leftAnchor, paddingTop: screenHeight * 0.03, paddingLeft: screenWidth * 0.05)
        
        let bebekSeparatorView = UIView()
        bebekSeparatorView.backgroundColor = .black
        thirdContainerView.addSubview(bebekSeparatorView)
        bebekSeparatorView.anchor(top: bebekStackView.bottomAnchor, left: thirdContainerView.leftAnchor, right: thirdContainerView.rightAnchor, paddingTop: 4, paddingLeft: 15, paddingRight: screenWidth * 0.2, height: 1)
        
        let imagePassengerStackView = UIStackView()
        imagePassengerStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdContainerView.addSubview(imagePassengerStackView)
        imagePassengerStackView.addArrangedSubview(passengerImageView)
        
        imagePassengerStackView.anchor(top: thirdContainerView.topAnchor, left: thirdContainerView.leftAnchor, right: secondContainerView.rightAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.7, paddingRight: screenWidth * 0.03, height: screenHeight * 0.15 )
        
        
        
        view.addSubview(reservationButton)
        reservationButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: screenHeight * 0.02, paddingRight: screenWidth * 0.05)
        
    }
    
    func fetchFlightDetails() {
        guard let id = flightID else { return }
        self.flightID = id
        viewModel.getSelectedFlight(id: String(id)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let flight):
                    self.updateUI(with: flight)
                case .failure(let error):
                    print("Error fetching flight details: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    func formatDateTime(_ dateTime: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateTime) {
            return outputFormatter.string(from: date)
        } else {
            return dateTime
        }
    }
    
    func updateUI(with flight: FlightSearchResult) {
        airlineNameLabel.text = "\(flight.airlineName)"
        departureCityLabel.text = "\(flight.departureCity)"
        landingCityLabel.text = "\(flight.landingCity)"
        durationInfoLabel.text = "\(flight.duration) Saat"
        departureTimeInfoLabel.text = formatDateTime(flight.departureTime)
        arrivelTimeInfoLabel.text = formatDateTime(flight.arrivalTime)
        yetiskinPriceLabel.text = "\(flight.adultSeatPrice) $"
        cocukPriceLabel.text = "\(flight.childPrice) $"
        bebekPriceLabel.text = "\(flight.infantPrice) $"
        yetiskinPriceLabel.font = UIFont.boldSystemFont(ofSize: yetiskinLabel.font.pointSize)
        cocukPriceLabel.font = UIFont.boldSystemFont(ofSize: cocukLabel.font.pointSize)
        bebekPriceLabel.font = UIFont.boldSystemFont(ofSize: bebekLabel.font.pointSize)
    }
    @objc func reservationButtonTapped() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            // AccessToken değeri nil olduğunda
            let alertController = UIAlertController(title: "Uyarı", message: "Lütfen giriş yapın", preferredStyle: .alert)
            
            // Giriş yap butonu
            let loginAction = UIAlertAction(title: "Giriş Yap", style: .default) { _ in
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
            alertController.addAction(loginAction)
            
            // Tamam butonu
            let cancelAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // AccessToken değeri nil değilse
        if let flightID = flightID {
            let vc = FlightReservationViewController()
            vc.flightID = flightID
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // FlightID değeri nil olduğunda
            let alertController = UIAlertController(title: "Uyarı", message: "Uçuş bilgileri yüklenirken bir hata oluştu", preferredStyle: .alert)
            
            // Tamam butonu
            let cancelAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
}
