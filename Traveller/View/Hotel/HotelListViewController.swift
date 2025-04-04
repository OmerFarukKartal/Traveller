import UIKit

class HotelListViewController: UIViewController {
    
    let viewModel = HotelViewModel.shared
    var tableView = UITableView()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var locationId: Int
    var hotelId: Int?
    var dayDifference: Int?
    var girisTarihi: String?
    var cikisTarihi: String?


    let seferListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Otel Listesi"
        return label
    }()
    
    init(locationId: Int, dayDifference: Int, girisTarihi: String, cikisTarihi: String, postGirisTarihi: String, postCikisTarihi: String) {
        self.locationId = locationId
        self.dayDifference = dayDifference
        self.girisTarihi = girisTarihi
        self.cikisTarihi = cikisTarihi

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        print(dayDifference ?? 100)
        self.navigationItem.title = ""

    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        let seferListLabelStackView = UIStackView()
        seferListLabelStackView.backgroundColor = .white
        seferListLabelStackView.axis = .vertical
        seferListLabelStackView.distribution = .fill
        seferListLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seferListLabelStackView)
        seferListLabelStackView.addArrangedSubview(seferListLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(seferListLabel)
        seferListLabel.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.35, paddingRight: screenWidth * 0.35)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: "HotelTableViewCell")
        tableView.rowHeight = screenHeight * 0.1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: seferListLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: 0, paddingRight: 0)
    }
    
    func fetchData() {
        viewModel.searchHotel(locationId: locationId) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HotelListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell", for: indexPath) as! HotelTableViewCell
        
        let hotel = viewModel.hotels[indexPath.row]
        cell.setImage(hotel.image)
        cell.hotelNameLabel.text = hotel.name
        cell.locationLabel.text = hotel.locationName
        cell.ratingBar.rating = hotel.stars ?? 0
        cell.setRate(Double(hotel.rating ?? 0))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotelDetails = viewModel.hotels[indexPath.row]
        guard let id = hotelDetails.id else { return }
        
        let hotelDetailVC = HotelDetailViewController()
        hotelDetailVC.hotelId = id
        hotelDetailVC.dayDifference = dayDifference
        hotelDetailVC.girisTarihi = girisTarihi
        hotelDetailVC.cikisTarihi = cikisTarihi
        
        navigationController?.pushViewController(hotelDetailVC, animated: true)
    }

}

