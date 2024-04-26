//
//  HotelViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 30.04.2024.
//

import UIKit

class HotelViewController: UIViewController {
    
    var tableView = UITableView()
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let nereyePickerView = UIPickerView()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: "HotelTableViewCell")

    }
    
    func setupUI() {
        
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addSubview(titleLabel)
        
        let nereyeLabel = UILabel()
        nereyeLabel.translatesAutoresizingMaskIntoConstraints = false
        nereyeLabel.text = "Gidilecek Yer:"
        
        let girisTarihiLabel = UILabel()
        girisTarihiLabel.translatesAutoresizingMaskIntoConstraints = false
        girisTarihiLabel.text = "Giriş Tarihi: "
        
        let populerHotelsLabel = UILabel()
        populerHotelsLabel.translatesAutoresizingMaskIntoConstraints = false
        populerHotelsLabel.text = "Populer Hotels"
        view.addSubview(populerHotelsLabel)
        
        let cikisTarihiLabel = UILabel()
        cikisTarihiLabel.translatesAutoresizingMaskIntoConstraints = false
        cikisTarihiLabel.text = "Çıkış Tarihi: "

        let nereyeTextField = UITextField()
        nereyeTextField.translatesAutoresizingMaskIntoConstraints = false
        nereyeTextField.placeholder = "Lütfen Şehir Seçiniz"
        nereyeTextField.borderStyle = .roundedRect

        let searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Ara", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = UIColor.red
        searchButton.layer.cornerRadius = 8
        searchButton.addTarget(self, action: #selector(hotelSearch), for: .touchUpInside)
        
        let girisTarihiPicker: UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(girisTarihiPickerValueChanged(_:)), for: .valueChanged)
            datePicker.date = Date()
            return datePicker
        }()
        
        let cikisTarihiPicker: UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(cikisTarihiPickerValueChanged(_:)), for: .valueChanged)
            datePicker.date = Date()
            return datePicker
        }()
        
        
        let tarihStackView = UIStackView()
        tarihStackView.axis = .vertical
        tarihStackView.spacing = screenHeight * 0.01
        tarihStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarihStackView)
        
        let girisTarihStackView = UIStackView()
        girisTarihStackView.axis = .horizontal
        girisTarihStackView.spacing = 0
        girisTarihStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarihStackView)
        girisTarihStackView.addArrangedSubview(girisTarihiLabel)
        girisTarihStackView.addArrangedSubview(girisTarihiPicker)
        tarihStackView.addArrangedSubview(girisTarihStackView)
        
        let cikisTarihStackView = UIStackView()
        cikisTarihStackView.axis = .horizontal
        cikisTarihStackView.spacing = 0
        cikisTarihStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarihStackView)
        cikisTarihStackView.addArrangedSubview(cikisTarihiLabel)
        cikisTarihStackView.addArrangedSubview(cikisTarihiPicker)
        tarihStackView.addArrangedSubview(cikisTarihStackView)
        
        let nereyeStackView = UIStackView()
        nereyeStackView.axis = .horizontal
        nereyeStackView.spacing = 0
        nereyeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nereyeStackView)
        
        
//        Constraits
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        nereyeStackView.addArrangedSubview(nereyeLabel)
        nereyeStackView.addArrangedSubview(nereyeTextField)
        nereyeStackView.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.18)
        
        tarihStackView.anchor(top: nereyeStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.35)
        
        view.addSubview(searchButton)
        searchButton.anchor(top: tarihStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.24, paddingRight: screenWidth * 0.3)

        view.addSubview(populerHotelsLabel)
        populerHotelsLabel.anchor(top: searchButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.34, paddingRight: screenWidth * 0.34)
        
        view.addSubview(tableView)
            tableView.anchor(top: populerHotelsLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: 0, paddingRight: 0)
    }
    
    
    @objc func hotelSearch() {
        
    }
    
    @objc func girisTarihiPickerValueChanged(_ sender: UIDatePicker) {
        
    }
    
    @objc func cikisTarihiPickerValueChanged(_ sender: UIDatePicker) {
        
    }
}

