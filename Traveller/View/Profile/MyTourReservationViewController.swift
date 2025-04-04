import UIKit

class MyTourReservationViewController: UIViewController {
    
    var reservedImageUrls: [String] = []
    var reversedReservedImageUrls: [String] = []
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var tableView = UITableView()
    let tourRezervasyonlarımLabel = UILabel()
    var viewModel = ToursViewModel()
    let emptyStateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.getTourReservation {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateEmptyState()
            }
        }
        let userDefaults = UserDefaults.standard
        reservedImageUrls = userDefaults.stringArray(forKey: "reservedTourImageUrl") ?? []
        print("Reserved Image URLs: \(reservedImageUrls)")
        reversedReservedImageUrls = reservedImageUrls.reversed()
        updateEmptyState()
    }
    
    func setupUI() {
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
        
        view.addSubview(tourRezervasyonlarımLabel)
        tourRezervasyonlarımLabel.textColor = .black
        tourRezervasyonlarımLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        tourRezervasyonlarımLabel.textAlignment = .center
        tourRezervasyonlarımLabel.text = "Tur Rezervasyonlarım"
        tourRezervasyonlarımLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.3)
        
        let cizgi = UIView()
        cizgi.backgroundColor = .black
        cizgi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cizgi)
        cizgi.anchor(top: tourRezervasyonlarımLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 2, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.anchor(top: cizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.rowHeight = screenHeight * 0.2
        tableView.register(MyTourReservationTableViewCell.self, forCellReuseIdentifier: "MyTourReservationTableViewCell")
        
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

extension MyTourReservationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tourReservation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTourReservationTableViewCell", for: indexPath) as! MyTourReservationTableViewCell
        let reservation = viewModel.tourReservation[indexPath.row]
        
        cell.personLabel.text = "\(reservation.person) Kişi"
        cell.priceLabel.text = "\(reservation.totalPrice)$"
        cell.nameLabel.text = reservation.tourName
        cell.setImage(reversedReservedImageUrls[indexPath.row])

        return cell
    }
}
