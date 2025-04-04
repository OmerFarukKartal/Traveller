//
//  MyFlightTicketTableViewCell.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 8.06.2024.
//

import UIKit

class MyFlightTicketTableViewCell: UITableViewCell {
    
    var departureCityLabel = UILabel()
    var landingCityLabel = UILabel()
    var priceLabel = UILabel()
    var nameLabel = UILabel()
    var emailLabel = UILabel()
    var phoneLabel = UILabel()
    var ageInfoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = .white
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(containerView)
        
        // Set the font to bold and increase the size by 1.5 times
        departureCityLabel.font = UIFont.boldSystemFont(ofSize: departureCityLabel.font.pointSize * 1.5)
        landingCityLabel.font = UIFont.boldSystemFont(ofSize: landingCityLabel.font.pointSize * 1.5)
        
        contentView.addSubview(departureCityLabel)
        departureCityLabel.translatesAutoresizingMaskIntoConstraints = false
        departureCityLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 2, paddingLeft: 50)
        
        contentView.addSubview(landingCityLabel)
        landingCityLabel.translatesAutoresizingMaskIntoConstraints = false
        landingCityLabel.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 2, paddingRight: 50)
        
        let cizgi = UIView()
        contentView.addSubview(cizgi)
        cizgi.translatesAutoresizingMaskIntoConstraints = false
        cizgi.backgroundColor = .black
        cizgi.anchor(top: contentView.topAnchor, left: departureCityLabel.rightAnchor, right: landingCityLabel.leftAnchor, paddingTop: 18, paddingLeft: 10, paddingRight: 10, height: 1)
        
        containerView.anchor(top: cizgi.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 50, paddingRight: 50, height: 120)
        
        containerView.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.anchor(top: departureCityLabel.bottomAnchor, left: containerView.leftAnchor, paddingTop: 20, paddingLeft: 30)
        
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.anchor(top: emailLabel.bottomAnchor, left: containerView.leftAnchor, paddingTop: 15, paddingLeft: 30)
        
        containerView.addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.anchor(top: nameLabel.bottomAnchor, left: containerView.leftAnchor, paddingTop: 15, paddingLeft: 30)
        
        containerView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.anchor(top: nameLabel.bottomAnchor, right: containerView.rightAnchor, paddingTop: 15, paddingRight: 30)
    }
}
