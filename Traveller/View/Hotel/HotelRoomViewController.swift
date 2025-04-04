import UIKit

class HotelRoomViewController: UIViewController {
    var viewModel = HotelViewModel.shared
    var tableView = UITableView()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var hotelId: Int?
    var daydiference: Int?
    var girisTarihi: String?
    var cikisTarihi: String?
    var imageUrl: String = ""
    
    let odaListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Oda Listesi"
        return label
    }()
    init(hotelId: Int, daydiference: Int, girisTarihi: String, cikisTarihi: String, imageUrl: String) {
        self.hotelId = hotelId
        self.daydiference = daydiference
        self.girisTarihi = girisTarihi
        self.cikisTarihi = cikisTarihi
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()    
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
        seferListLabelStackView.addArrangedSubview(odaListLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        view.addSubview(odaListLabel)
        odaListLabel.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.38, paddingRight: screenWidth * 0.39)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HotelRoomTableViewCell.self, forCellReuseIdentifier: "HotelRoomTableViewCell")
        tableView.rowHeight = screenHeight * 0.20
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: odaListLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: 0, paddingRight: 0)
        
    }
    func fetchData() {
        viewModel.getHotelRoom(hotelId: hotelId!) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension HotelRoomViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelRoomTableViewCell", for: indexPath) as! HotelRoomTableViewCell
        
        let rooms = viewModel.rooms[indexPath.row]
        cell.setImage(rooms.roomImage)
        cell.priceLabel.text = "\(rooms.roomPrice ?? 0) $"
        cell.roomTypeLabel.text = rooms.roomType
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            let alertController = UIAlertController(title: "Uyarı", message: "Lütfen giriş yapın", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Giriş Yap", style: .default) { _ in
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
            alertController.addAction(loginAction)
            let cancelAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let roomId = viewModel.rooms[indexPath.row].hotelRoomID
        let rooms = viewModel.rooms[indexPath.row]
        let vc = HotelReservationViewController()
        vc.roomId = roomId
        vc.daydiference = daydiference
        vc.girisTarihi = girisTarihi
        vc.cikisTarihi = cikisTarihi
        vc.price = rooms.roomPrice
        vc.imageUrl = imageUrl
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
