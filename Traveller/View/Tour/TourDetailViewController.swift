//
//  TourDetailViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 26.05.2024.
//

import UIKit
import Kingfisher

class TourDetailViewController: UIViewController {

    var tourId: Int?
    let viewModel = ToursViewModel()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let tourNameLabel = UILabel()
    let turIsimLabel = UILabel()
    var tourTypeLabel = UILabel()
    var turTipiLabel = UILabel()
    var priceLabel = UILabel()
    var priceInfoLabel = UILabel()
    var locationInfoLabel = UILabel()
    var locationLabel = UILabel()
    var tourDescriptionLabel = UILabel()
    var tourDescriptionInfoTextView = UILabel()
    var tourImageView = UIImageView()
    var imageContainerView = UIView()
    let ratingBar = RatingBar()
    var rateLabel = UILabel()
    var kisiSayisi: Int?
    var imageUrl: String = ""

    
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
        fetchTourDetails()
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
        
        let rateStackView = UIStackView()
        rateStackView.axis = .horizontal
        rateStackView.spacing = 30
        rateStackView.backgroundColor = UIColor.systemGreen
        rateStackView.layer.cornerRadius = 2
        rateStackView.distribution = .equalCentering
        rateStackView.alignment = .center
        rateStackView.translatesAutoresizingMaskIntoConstraints = false
        rateStackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        rateStackView.isLayoutMarginsRelativeArrangement = true

        
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowOpacity = 0.8
        imageContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageContainerView.layer.shadowRadius = 4
        imageContainerView.layer.masksToBounds = false
        view.addSubview(imageContainerView)
        imageContainerView.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenHeight * 0.02, paddingRight: screenHeight * 0.02, height: screenHeight * 0.3)
        
        tourImageView.translatesAutoresizingMaskIntoConstraints = false
        tourImageView.contentMode = .scaleAspectFill
        tourImageView.clipsToBounds = true
        tourImageView.image = UIImage(named: "placeholderImage")
        imageContainerView.addSubview(tourImageView)
        tourImageView.anchor(top: imageContainerView.topAnchor, left: imageContainerView.leftAnchor, bottom: imageContainerView.bottomAnchor, right: imageContainerView.rightAnchor)
        
        ratingBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingBar)
        ratingBar.anchor(top: imageContainerView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.05)
        
        view.addSubview(rateStackView)
        rateLabel.textColor = .white
        rateStackView.addArrangedSubview(rateLabel)
        rateStackView.anchor(top: imageContainerView.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.05, paddingRight: screenWidth * 0.05)
        
        view.addSubview(turIsimLabel)
        turIsimLabel.textColor = .black
        turIsimLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        turIsimLabel.textAlignment = .center
        turIsimLabel.text = "Tur İsmi:"
        turIsimLabel.anchor(top: ratingBar.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        
        
        tourNameLabel.textColor = .black
        tourNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        tourNameLabel.textAlignment = .center
        tourNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tourNameLabel)
        tourNameLabel.anchor(top: ratingBar.bottomAnchor, left: turIsimLabel.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02)
        
        view.addSubview(locationLabel)
        locationLabel.textColor = .black
        locationLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        locationLabel.textAlignment = .center
        locationLabel.text = "Konum:"
        locationLabel.anchor(top: turIsimLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        locationInfoLabel.textColor = .black
        locationInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        locationInfoLabel.textAlignment = .center
        locationInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationInfoLabel)
        locationInfoLabel.anchor(top: turIsimLabel.bottomAnchor, left: locationLabel.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02)
        
        view.addSubview(turTipiLabel)
        turTipiLabel.textColor = .black
        turTipiLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        turTipiLabel.textAlignment = .center
        turTipiLabel.text = "Tur Tipi:"
        turTipiLabel.anchor(top: locationLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        tourTypeLabel.textColor = .black
        tourTypeLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        tourTypeLabel.textAlignment = .center
        tourTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tourTypeLabel)
        tourTypeLabel.anchor(top: locationInfoLabel.bottomAnchor, left: turTipiLabel.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02)
        
        tourDescriptionLabel.textColor = .black
        tourDescriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        tourDescriptionLabel.textAlignment = .center
        tourDescriptionLabel.text = "Açıklama:"
        view.addSubview(tourDescriptionLabel)
        tourDescriptionLabel.anchor(top: tourTypeLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        tourDescriptionInfoTextView.textColor = .black
        tourDescriptionInfoTextView.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        tourDescriptionInfoTextView.numberOfLines = 0
        tourDescriptionInfoTextView.lineBreakMode = .byWordWrapping // Ek olarak, lineBreakMode'u ayarladım.
        view.addSubview(tourDescriptionInfoTextView)
        tourDescriptionInfoTextView.anchor(top: tourTypeLabel.bottomAnchor, left: tourDescriptionLabel.rightAnchor,right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02, paddingRight: screenWidth * 0.02)
        
        view.addSubview(reservationButton)
        reservationButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: screenHeight * 0.02, paddingRight: screenWidth * 0.05)

        view.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 20)
        priceLabel.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: reservationButton.leftAnchor, paddingBottom: screenHeight * 0.025, paddingRight: screenWidth * 0.02)

    }
    
    func fetchTourDetails() {
        guard let id = tourId else { return }
        viewModel.getSelectedTour(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tour):
                    self.updateUI(with: tour)
                case .failure(let error):
                    print("Error fetching flight details: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setImage(_ url: String?, size: CGSize? = nil) {
        guard let urlStr = url else {
            self.tourImageView.image = UIImage(named: "notFound")
            return
        }
        if url == "notFound" {
            self.tourImageView.image = UIImage(named: "notFound")
        } else {
            let tourImage = URL(string: urlStr)
            var options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
            
            if let size = size {
                let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
                options.append(.processor(processor))
            }
            
            self.tourImageView.kf.setImage(with: tourImage, placeholder: UIImage(named: "notFound"), options: options)
        }
    }
    
    func setRate(_ rate: Double) {
          rateLabel.text = String(format: "%.1f", rate)
      }
    
    func updateUI(with tour: TourWithId) {
        if let imageUrl = tour.image {
            setImage(imageUrl, size: CGSize(width: screenWidth - screenHeight * 0.04, height: screenHeight * 0.3))
            self.imageUrl = imageUrl
        } else {
            // Varsayılan görüntü atanabilir, örneğin:
            self.tourImageView.image = UIImage(named: "notFound")
        }
        tourNameLabel.text = "\(tour.name ?? "")"
        priceLabel.text = "\(tour.tourAdultPrice)$"
        locationInfoLabel.text = "\(tour.location ?? "")"
        tourTypeLabel.text = "\(tour.tourTypeName ?? "")"
        tourDescriptionInfoTextView.text = "\(tour.description ?? "")"
        ratingBar.rating = tour.stars
        setRate(Double(tour.rating))
    }
    
    @objc func reservationButtonTapped() {
        guard UserDefaults.standard.string(forKey: "accessToken") != nil else {
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
        
        let vc = TourReservationViewController()
        vc.kisiSayisi = kisiSayisi
        vc.tourId = tourId
        vc.imageUrl = self.imageUrl
        if let priceText = priceLabel.text, let price = Int(priceText.replacingOccurrences(of: "$", with: "")) {
            vc.price = price
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
