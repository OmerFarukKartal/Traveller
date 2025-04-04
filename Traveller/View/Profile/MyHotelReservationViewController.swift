import UIKit

class MyHotelReservationViewController: UIViewController {
    
    var tableView = UITableView()
    var viewModel = HotelViewModel()
    var roomId: Int?
    var hotelDetails: HotelWithId?
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let hotelRezervasyonlarımLabel = UILabel()
    var reservedImageUrls: [String] = []
    var reversedReservedImageUrls: [String] = []
    let emptyStateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.getHotelReservation {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateEmptyState()
            }
        }
        let userDefaults = UserDefaults.standard
        reservedImageUrls = userDefaults.stringArray(forKey: "reservedImageUrl") ?? []
        print("Reserved Image URLs: \(reservedImageUrls)")
        reversedReservedImageUrls = reservedImageUrls.reversed()
        updateEmptyState()
    }
    
    func setupUI () {
        view.backgroundColor = .white
        
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
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(hotelRezervasyonlarımLabel)
        hotelRezervasyonlarımLabel.textColor = .black
        hotelRezervasyonlarımLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        hotelRezervasyonlarımLabel.textAlignment = .center
        hotelRezervasyonlarımLabel.text = "Otel Rezervasyonlarım"
        hotelRezervasyonlarımLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.3)
        
        let cizgi = UIView()
        cizgi.backgroundColor = .black
        cizgi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cizgi)
        cizgi.anchor(top: hotelRezervasyonlarımLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 2, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.anchor(top: cizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.rowHeight = screenHeight * 0.2
        tableView.register(MyHotelReservationTableViewCell.self, forCellReuseIdentifier: "MyHotelReservationTableViewCell")
        
        // Boş durum için etiket oluştur
        view.addSubview(emptyStateLabel)
        emptyStateLabel.text = "Rezervasyon yok"
        emptyStateLabel.textColor = .gray
        emptyStateLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func updateEmptyState() {
        emptyStateLabel.isHidden = !reversedReservedImageUrls.isEmpty
    }
}

extension MyHotelReservationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hotelReservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyHotelReservationTableViewCell", for: indexPath) as! MyHotelReservationTableViewCell
        
        let reservationInfo = viewModel.hotelReservations[indexPath.row]
        
        // Format dates
        let originalDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let displayDateFormat = "dd/MM/yyyy"
        
        cell.girisTarihiLabel.text = formatDateString(reservationInfo.checkInDate, fromFormat: originalDateFormat, toFormat: displayDateFormat)
        cell.cikisTarihiLabel.text = formatDateString(reservationInfo.checkOutDate, fromFormat: originalDateFormat, toFormat: displayDateFormat)
        cell.nameLabel.text = reservationInfo.username
        
        // Format price
        if let totalPrice = reservationInfo.totalPrice {
            let formattedPrice = formatPrice(totalPrice)
            cell.priceLabel.text = formattedPrice
        } else {
            cell.priceLabel.text = nil
        }
        
        cell.setImage(reversedReservedImageUrls[indexPath.row])
        return cell
    }
    
    // Helper function to format date strings
    func formatDateString(_ dateString: String?, fromFormat: String, toFormat: String) -> String? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent parsing
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    // Helper function to format price
    func formatPrice(_ price: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "USD" // or any other currency code as needed
        return numberFormatter.string(from: NSNumber(value: price))
    }
}
