//
//  TourReservationViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 29.05.2024.
//

import UIKit

class TourReservationViewController: UIViewController {

    var kisiSayisi: Int?
    var tourId: Int?
    var price: Int?
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var viewModel = ToursViewModel()
    var imageUrl: String = ""
    
    let reservationInfoLabel: UILabel = {
        let reservationInfolabel = UILabel()
        reservationInfolabel.translatesAutoresizingMaskIntoConstraints = false
        reservationInfolabel.text = "Rezervasyon Bilgileri"
        return reservationInfolabel
    }()
    
    
    let kisiSayisiLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kişi Sayısı:"
        return label
    }()
    
    let kisiSayisiInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let odenecekTutarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Toplam Tutar:"
        return label
    }()
    
    let odenecekTutarInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        print(tourId ?? 0, kisiSayisi ?? 0, price ?? 0)
        calculateTotalAmount()
        self.navigationItem.title = ""
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
        
        view.addSubview(reservationInfoLabel)
        reservationInfoLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.3)
        
        let reservationInfoSeparatorView = UIView()
        reservationInfoSeparatorView.backgroundColor = .black
        view.addSubview(reservationInfoSeparatorView)
        reservationInfoSeparatorView.anchor(top: reservationInfoLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 2, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.05, height: 1)

        view.addSubview(kisiSayisiLabel)
        view.addSubview(kisiSayisiInfoLabel)
        if let kisiSayisi = kisiSayisi {
                kisiSayisiInfoLabel.text = "\(kisiSayisi)"
            }
        kisiSayisiLabel.anchor(top: reservationInfoSeparatorView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        kisiSayisiInfoLabel.anchor(top: reservationInfoSeparatorView.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingRight: screenWidth * 0.5)
        
        view.addSubview(odenecekTutarLabel)
        view.addSubview(odenecekTutarInfoLabel)
        odenecekTutarLabel.anchor(top: kisiSayisiInfoLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        odenecekTutarInfoLabel.anchor(top: kisiSayisiInfoLabel.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingRight: screenWidth * 0.5)
        
       
        
        
        
        view.addSubview(odemeButton)
        odemeButton.anchor(top: odenecekTutarLabel.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingRight: screenWidth * 0.05)
        
    }
    
    @objc func odemeButtonTapped () {
        guard let tourID = tourId,
              let person = kisiSayisi
        else {
            displayErrorAlert(message: "Hata")
            return
        }
        viewModel.createTourReservation(tourID: tourID, person: person) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                print(success.message)
                let vc = TourWebViewController()
                self.saveTourImageUrlToUserDefaults(imageUrl: self.imageUrl)
                navigationController?.pushViewController(vc, animated: true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    private func saveTourImageUrlToUserDefaults(imageUrl: String) {
        let userDefaultsTour = UserDefaults.standard
        var tourImageUrlArray = userDefaultsTour.stringArray(forKey: "reservedTourImageUrl") ?? []
        tourImageUrlArray.append(imageUrl)
        userDefaultsTour.set(tourImageUrlArray, forKey: "reservedTourImageUrl")
    }
    
    func calculateTotalAmount() {
        if let kisiSayisi = kisiSayisi, let price = price {
            let totalAmount = kisiSayisi * price
            odenecekTutarInfoLabel.text = "\(totalAmount) $"
        }
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
