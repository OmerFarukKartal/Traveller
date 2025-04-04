import UIKit

class ProfileViewController: UIViewController{

    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var profileLabel = UILabel()
    
    let tableView = UITableView()
    let tableData = [
        ("Uçak Biletlerim", "airplane"),
        ("Otel Rezervasyonlarım", "bed.double"),
        ("Tur Rezervasyonlarım", "globe.asia.australia.fill"),
        ("Profil", "person.crop.circle"),
        ("Hakkımızda", "info.circle")
    ]
    
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.text = "Profil"
        view.addSubview(profileLabel)
        profileLabel.anchor(top: titleStackView.bottomAnchor, paddingTop: 20, height: 30)
        profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Merkeze hizalama eklendi
        
        let profileCizgi = UIView()
        profileCizgi.translatesAutoresizingMaskIntoConstraints = false
        profileCizgi.backgroundColor = .black
        view.addSubview(profileCizgi) // Eksik olan ekleme işlemi
        profileCizgi.anchor(top: profileLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 3, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        // TableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.anchor(top: profileCizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        // Register UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        logoutButton.backgroundColor = .red
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        logoutButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: screenWidth * 0.3, paddingBottom: screenHeight * 0.35, paddingRight: screenWidth * 0.3, height: 40) // Koordinatlar güncellendi
        
        updateUI()
    }
    
    func updateUI() {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        let isLoggedIn = token != nil
        
        tableView.isHidden = !isLoggedIn
        if isLoggedIn {
            logoutButton.setTitle("   Çıkış Yap", for: .normal)
            logoutButton.setImage(UIImage(systemName: "door.left.hand.closed"), for: .normal)
            logoutButton.tintColor = .white
            
        } else {
            logoutButton.setTitle("   Giriş Yap", for: .normal)
            logoutButton.setImage(UIImage(systemName: "door.left.hand.open"), for: .normal)
            logoutButton.tintColor = .white
        }
    }
    
    @objc func logoutButtonTapped() {
        let token = UserDefaults.standard.string(forKey: "accessToken")
        
        if token != nil {
            UserDefaults.standard.removeObject(forKey: "accessToken")
            updateUI()
            tabBarController?.selectedIndex = 0 // TabBarController'ın ilk sekmesini göster
        } else {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }
        logoutButton.tintColor = .white
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let (text, imageName) = tableData[indexPath.row]
        cell.textLabel?.text = text
        cell.imageView?.image = UIImage(systemName: imageName)
        
        if let image = UIImage(systemName: imageName) {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            cell.imageView?.image = tintedImage
            cell.imageView?.tintColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = tableData[indexPath.row].0
        
        switch selectedItem {
        case "Uçak Biletlerim":
            let myFlightTicketVC = MyFlightTicketViewController()
            navigationController?.pushViewController(myFlightTicketVC, animated: true)
        case "Otel Rezervasyonlarım":
            let myHotelReservationVC = MyHotelReservationViewController()
            navigationController?.pushViewController(myHotelReservationVC, animated: true)
        case "Tur Rezervasyonlarım":
            let myTourReservationVC = MyTourReservationViewController()
            navigationController?.pushViewController(myTourReservationVC, animated: true)
        default:
            break
        }
    }
}
