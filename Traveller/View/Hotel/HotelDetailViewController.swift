//
//  HotelDetailViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 21.05.2024.
//

import UIKit
import Kingfisher

class HotelDetailViewController: UIViewController {
    
    var hotelId: Int?
    var viewModel = HotelViewModel()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let hotelNameLabel = UILabel()
    let hotelIsimLabel = UILabel()
    var priceLabel = UILabel()
    var priceInfoLabel = UILabel()
    var locationInfoLabel = UILabel()
    var locationLabel = UILabel()
    var hotelDescriptionLabel = UILabel()
    var hotelDescriptionInfoTextView = UILabel()
    var hotelImageView = UIImageView()
    var imageContainerView = UIView()
    let ratingBar = RatingBar()
    var rateLabel = UILabel()
    var dayDifference: Int?
    var girisTarihi: String?
    var cikisTarihi: String?
    let imageStackView = UIStackView()
    let systemImage1 = UIImageView(image: UIImage(systemName: "21.circle"))
    let systemImage2 = UIImageView(image: UIImage(systemName: "fork.knife.circle"))
    let systemImage3 = UIImageView(image: UIImage(systemName: "wifi"))
    let systemImage4 = UIImageView(image: UIImage(systemName: "parkingsign.circle"))
    var imageUrl: String = ""
    
    let reservationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Oda Seç  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(reservationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchHotelDetails()
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
        
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        hotelImageView.contentMode = .scaleAspectFill
        hotelImageView.clipsToBounds = true
        hotelImageView.image = UIImage(named: "placeholderImage")
        imageContainerView.addSubview(hotelImageView)
        hotelImageView.anchor(top: imageContainerView.topAnchor, left: imageContainerView.leftAnchor, bottom: imageContainerView.bottomAnchor, right: imageContainerView.rightAnchor)
        
        ratingBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingBar)
        ratingBar.anchor(top: imageContainerView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.05, paddingLeft: screenWidth * 0.05)
        
        view.addSubview(rateStackView)
        rateLabel.textColor = .white
        rateStackView.addArrangedSubview(rateLabel)
        rateStackView.anchor(top: imageContainerView.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.05, paddingRight: screenWidth * 0.05)
        
        view.addSubview(hotelIsimLabel)
        hotelIsimLabel.textColor = .black
        hotelIsimLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        hotelIsimLabel.textAlignment = .center
        hotelIsimLabel.text = "Hotel İsmi:"
        hotelIsimLabel.anchor(top: ratingBar.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        hotelNameLabel.textColor = .black
        hotelNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        hotelNameLabel.textAlignment = .center
        hotelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hotelNameLabel)
        hotelNameLabel.anchor(top: ratingBar.bottomAnchor, left: hotelIsimLabel.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02)
        
        view.addSubview(locationLabel)
        locationLabel.textColor = .black
        locationLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        locationLabel.textAlignment = .center
        locationLabel.text = "Konum:"
        locationLabel.anchor(top: hotelIsimLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        locationInfoLabel.textColor = .black
        locationInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        locationInfoLabel.textAlignment = .center
        locationInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationInfoLabel)
        locationInfoLabel.anchor(top: hotelIsimLabel.bottomAnchor, left: locationLabel.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02)
        
        hotelDescriptionLabel.textColor = .black
        hotelDescriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        hotelDescriptionLabel.text = "Açıklama:"
        view.addSubview(hotelDescriptionLabel)
        hotelDescriptionLabel.anchor(top: locationLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.05)
        
        hotelDescriptionInfoTextView.textColor = .black
        hotelDescriptionInfoTextView.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        hotelDescriptionInfoTextView.numberOfLines = 0
        hotelDescriptionInfoTextView.lineBreakMode = .byWordWrapping // Ek olarak, lineBreakMode'u ayarladım.
        view.addSubview(hotelDescriptionInfoTextView)
        hotelDescriptionInfoTextView.anchor(top: locationInfoLabel.bottomAnchor,left: hotelDescriptionLabel.rightAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.02, paddingRight: screenWidth * 0.02
        )
        
        view.addSubview(reservationButton)
        reservationButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: screenHeight * 0.02, paddingRight: screenWidth * 0.05)
        
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageStackView)
        imageStackView.axis = .horizontal
        imageStackView.distribution = .fillEqually
        imageStackView.spacing = 5
        
        imageStackView.addArrangedSubview(systemImage1)
        imageStackView.addArrangedSubview(systemImage2)
        imageStackView.addArrangedSubview(systemImage3)
        imageStackView.addArrangedSubview(systemImage4)
        
        imageStackView.anchor(top: imageContainerView.bottomAnchor, left: ratingBar.rightAnchor, paddingTop: screenHeight * 0.045, paddingLeft: screenWidth * 0.1, width: 160, height: 30)
        
        let imageViews = [systemImage1, systemImage2, systemImage3, systemImage4]
        for imageView in imageViews {
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .black
        }
        
    }
    
    
    
    func fetchHotelDetails() {
        guard let id = hotelId else { return }
        viewModel.getSelectedHotel(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let hotel):
                    self.updateUI(with: hotel)
                case .failure(let error):
                    print("Error fetching flight details: \(error.localizedDescription)")
                    
                }
            }
        }
    }
    
    func setImage(_ url: String?, size: CGSize? = nil) {
        guard let urlStr = url else {
            self.hotelImageView.image = UIImage(named: "notFound")
            return
        }
        if url == "notFound" {
            self.hotelImageView.image = UIImage(named: "notFound")
        } else {
            let hotelImage = URL(string: urlStr)
            var options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
            
            if let size = size {
                let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
                options.append(.processor(processor))
            }
            
            self.hotelImageView.kf.setImage(with: hotelImage, placeholder: UIImage(named: "notFound"), options: options)
        }
    }
    func setRate(_ rate: Double) {
        rateLabel.text = String(format: "%.1f", rate)
    }
    
    
    func updateUI(with hotel: HotelWithId){
        if let imageUrl = hotel.image {
            setImage(imageUrl, size: CGSize(width: screenWidth, height: screenHeight * 0.3))
            self.imageUrl = imageUrl
            
        } else {
            self.hotelImageView.image = UIImage(named: "notFound")
        }
        hotelNameLabel.text = "\(hotel.name ?? "")"
        priceLabel.text = "\(hotel.price ?? 0)$"
        locationInfoLabel.text = "\(hotel.locationName ?? "")"
        hotelDescriptionInfoTextView.text = "\(hotel.description ?? "")"
        ratingBar.rating = hotel.rating ?? 0
        setRate(Double(hotel.rating!))
        
    }
    
    @objc func reservationButtonTapped() {
        guard let hotelId = hotelId else { return }
        viewModel.getHotelRoom(hotelId: hotelId) {
            DispatchQueue.main.async {
                let vc = HotelRoomViewController(hotelId: hotelId, daydiference: self.dayDifference!, girisTarihi: self.girisTarihi!, cikisTarihi: self.cikisTarihi!, imageUrl: self.imageUrl)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
