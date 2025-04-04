import UIKit

class HotelReservationViewController: UIViewController {
    
    var roomId: Int?
    var daydiference: Int?
    var girisTarihi: String?
    var girisTarihiInfoLabel = UILabel()
    var cikisTarihi: String?
    var cikisTarihiInfoLabel = UILabel()
    var price: Int?
    var totalPrice: Int?
    let totalPriceCizgi = UIView()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let odemeBilgileriLabel = UILabel()
    let odemeBilgiCizgi = UIView()
    let girisTarihiLabel = UILabel()
    let girisTarihiCizgi = UIView()
    let cikisTarihiLabel = UILabel()
    let cikisTarihiCizgi = UIView()
    let konaklamaSureLabel = UILabel()
    let konaklamaSureCizgi = UIView()
    var konaklamaSureInfoLabel = UILabel()
    let viewModel = HotelViewModel()
    var imageUrl: String = ""

    // Total Price Label
    let totalPriceLabel = UILabel()
    
    let odemeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Ödeme Yap  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(odemeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        findTotalPrice()
        self.navigationItem.title = ""
        print(roomId ?? 0)
        print(girisTarihi ?? "")
        print(cikisTarihi ?? "")
        print(daydiference ?? 0)
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
        
        view.addSubview(odemeBilgileriLabel)
        odemeBilgileriLabel.tintColor = .black
        odemeBilgileriLabel.translatesAutoresizingMaskIntoConstraints = false
        odemeBilgileriLabel.text = "Rezervasyon Bilgileri"
        odemeBilgileriLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.28, paddingRight: screenWidth * 0.28)
        
        odemeBilgiCizgi.backgroundColor = .black
        odemeBilgiCizgi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(odemeBilgiCizgi)
        odemeBilgiCizgi.anchor(top: odemeBilgileriLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        view.addSubview(girisTarihiLabel)
        girisTarihiLabel.tintColor = .black
        girisTarihiLabel.translatesAutoresizingMaskIntoConstraints = false
        girisTarihiLabel.text = "Giriş Tarihi:"
        
        girisTarihiLabel.anchor(top: odemeBilgiCizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)
        
        view.addSubview(girisTarihiInfoLabel)
        girisTarihiLabel.translatesAutoresizingMaskIntoConstraints = false
        girisTarihiInfoLabel.text = girisTarihi
        girisTarihiInfoLabel.anchor(top: odemeBilgiCizgi.bottomAnchor, left: girisTarihiLabel.rightAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)
        
        
        
        girisTarihiCizgi.translatesAutoresizingMaskIntoConstraints = false
        girisTarihiCizgi.backgroundColor = .black
        view.addSubview(girisTarihiCizgi)
        girisTarihiCizgi.anchor(top: girisTarihiLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        view.addSubview(cikisTarihiLabel)
        cikisTarihiLabel.tintColor = .black
        cikisTarihiLabel.translatesAutoresizingMaskIntoConstraints = false
        cikisTarihiLabel.text = "Çıkış Tarihi:"
        
        cikisTarihiLabel.anchor(top: girisTarihiCizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)
        
        view.addSubview(cikisTarihiInfoLabel)
        cikisTarihiInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        cikisTarihiInfoLabel.text = cikisTarihi
        cikisTarihiInfoLabel.anchor(top: girisTarihiCizgi.bottomAnchor, left: cikisTarihiLabel.rightAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)
        
        cikisTarihiCizgi.translatesAutoresizingMaskIntoConstraints = false
        cikisTarihiCizgi.backgroundColor = .black
        view.addSubview(cikisTarihiCizgi)
        cikisTarihiCizgi.anchor(top: cikisTarihiLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        konaklamaSureLabel.translatesAutoresizingMaskIntoConstraints = false
        konaklamaSureLabel.text = "Rez. Süresi:"
        view.addSubview(konaklamaSureLabel)
        konaklamaSureLabel.anchor(top: cikisTarihiCizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)
        
        konaklamaSureInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        konaklamaSureInfoLabel.text = "\(daydiference ?? 0)Gün"
        view.addSubview(konaklamaSureInfoLabel)
        konaklamaSureInfoLabel.anchor(top: cikisTarihiCizgi.bottomAnchor, left: konaklamaSureLabel.rightAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)
        
        
        konaklamaSureCizgi.translatesAutoresizingMaskIntoConstraints = false
        konaklamaSureCizgi.backgroundColor = .black
        view.addSubview(konaklamaSureCizgi)
        konaklamaSureCizgi.anchor(top: konaklamaSureLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        // Total Price Label
        totalPriceLabel.textColor = .black
        totalPriceLabel.textAlignment = .center
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalPriceLabel)
        totalPriceLabel.anchor(top: konaklamaSureCizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.1)

        totalPriceCizgi.translatesAutoresizingMaskIntoConstraints = false
        totalPriceCizgi.backgroundColor = .black
        view.addSubview(totalPriceCizgi)
        totalPriceCizgi.anchor(top: totalPriceLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1, height: 1)
        
        view.addSubview(odemeButton)
        odemeButton.anchor(top: totalPriceCizgi.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.05, paddingRight: screenWidth * 0.05)
        
        
    }
    
    
    @objc func odemeButtonTapped() {
        guard let hotelRoomId = roomId,
              let checkInDate = girisTarihi,
              let checkOutDate = cikisTarihi
        else {
            displayErrorAlert(message: "HATA!")
            return
        }
        viewModel.createHotelReservation(hotelRoomId: hotelRoomId, checkInDate: checkInDate, checkOutDate: checkOutDate) { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                print(success.message)
                let vc = HotelWebViewController()
                let vc2 = MyHotelReservationViewController()
                vc2.roomId = roomId
                self.saveHotelImageUrlToUserDefaults(imageUrl: self.imageUrl)
                navigationController?.pushViewController(vc, animated: true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    private func saveHotelImageUrlToUserDefaults(imageUrl: String) {
        let userDefaults = UserDefaults.standard
        var imageUrlArray = userDefaults.stringArray(forKey: "reservedImageUrl") ?? []
        imageUrlArray.append(imageUrl)
        userDefaults.set(imageUrlArray, forKey: "reservedImageUrl")
    }

    func findTotalPrice() {
        if let daydiference = daydiference, let price = price {
            totalPrice = daydiference * price
            if let totalPrice = totalPrice {
                totalPriceLabel.text = "Top. Ücret:           \(totalPrice)$"
            } else {
                totalPriceLabel.text = "Total Price: Calculation error"
            }
        } else {
            totalPriceLabel.text = "Total Price: Missing data"
        }
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
