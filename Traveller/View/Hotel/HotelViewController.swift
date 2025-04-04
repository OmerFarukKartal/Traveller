//
//  HotelViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 30.04.2024.
//

import UIKit

class HotelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var viewModel = HotelViewModel.shared
    var tableView = UITableView()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let nereyePickerView = UIPickerView()
    var hotelList: [[String]] = []
    var selectedHotelId: Int?
    
    var girisTarihi: Date = Date()
    var cikisTarihi: Date = Date()

    
    let nereyeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Lütfen Şehir Seçiniz"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchHotelList()
        pickerToolBar()
        viewModel.getPopularHotels {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.navigationItem.title = ""
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
        girisTarihiLabel.text = "Giriş Tarihi"
        
        let populerHotelsLabel = UILabel()
        populerHotelsLabel.translatesAutoresizingMaskIntoConstraints = false
        populerHotelsLabel.text = "Populer Hotels"
        view.addSubview(populerHotelsLabel)
        
        let cikisTarihiLabel = UILabel()
        cikisTarihiLabel.translatesAutoresizingMaskIntoConstraints = false
        cikisTarihiLabel.text = "Çıkış Tarihi"


        let searchButton = UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Ara", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = UIColor.red
        searchButton.layer.cornerRadius = 8
        searchButton.addTarget(self, action: #selector(searchHotel), for: .touchUpInside)
        
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
        tarihStackView.axis = .horizontal
        tarihStackView.spacing = screenWidth * 0.15
        tarihStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarihStackView)
        
        let girisTarihStackView = UIStackView()
        girisTarihStackView.axis = .vertical
        girisTarihStackView.spacing = screenHeight * 0.01
        girisTarihStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tarihStackView)
        girisTarihStackView.addArrangedSubview(girisTarihiLabel)
        girisTarihStackView.addArrangedSubview(girisTarihiPicker)
        tarihStackView.addArrangedSubview(girisTarihStackView)
        
        let cikisTarihStackView = UIStackView()
        cikisTarihStackView.axis = .vertical
        cikisTarihStackView.spacing = screenHeight * 0.01
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
        nereyeStackView.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1)
        
        tarihStackView.anchor(top: nereyeStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.12)
        
        view.addSubview(searchButton)
        searchButton.anchor(top: tarihStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.3, paddingRight: screenWidth * 0.24)

        view.addSubview(populerHotelsLabel)
        populerHotelsLabel.anchor(top: searchButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.34, paddingRight: screenWidth * 0.34)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: populerHotelsLabel.bottomAnchor,left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor ,paddingTop: screenHeight * 0.02, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.8)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: "HotelTableViewCell")
        tableView.rowHeight = screenHeight * 0.1
        
        nereyePickerView.delegate = self
        nereyePickerView.dataSource = self
        nereyeTextField.inputView = nereyePickerView

    }
    
    func fetchHotelList() {
        self.viewModel.getHotelList { [weak self] hotelData in
            DispatchQueue.main.async {
                self?.hotelList = hotelData
                self?.nereyePickerView.reloadAllComponents()
            }
        }
    }
    
    

    
    // MARK: - UIPickerViewDataSource & UIPickerViewDelegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hotelList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hotelList[row].first
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        nereyeTextField.text = hotelList[row][0]
        selectedHotelId = Int(hotelList[row][1])
    }
    
    func pickerToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        nereyeTextField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(title: "Seç", style: UIBarButtonItem.Style.done, target: self, action: #selector(dissmissPicker))
        doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func dissmissPicker() {
          view.endEditing(true)
      }
      
    @objc func searchHotel() {
        guard let locationId = selectedHotelId else { return }
        
        guard girisTarihi < cikisTarihi else {
            displayErrorAlert(message: "Geçerli bir çıkış tarihi seçiniz.")
            return
        }
        
        // Format the dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let girisTarihiString = dateFormatter.string(from: girisTarihi)
        let cikisTarihiString = dateFormatter.string(from: cikisTarihi)
        let postGirisTarihi = String(describing: girisTarihi)
        let postCikisTarihi = String(describing: cikisTarihi)
        
        let dayDifference = (Calendar.current.dateComponents([.day], from: girisTarihi, to: cikisTarihi).day ?? 0) + 1

        viewModel.searchHotel(locationId: locationId) {
            DispatchQueue.main.async {
                let vc = HotelListViewController(locationId: locationId, dayDifference: dayDifference, girisTarihi: girisTarihiString, cikisTarihi: cikisTarihiString, postGirisTarihi: postGirisTarihi, postCikisTarihi: postCikisTarihi)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    
    @objc func girisTarihiPickerValueChanged(_ sender: UIDatePicker) {
        girisTarihi = sender.date
    }
    
    @objc func cikisTarihiPickerValueChanged(_ sender: UIDatePicker) {
        cikisTarihi = sender.date
    }
    
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension HotelViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularHotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell", for: indexPath) as! HotelTableViewCell
        
        let hotel = viewModel.popularHotels[indexPath.row]
        cell.setImage(hotel.image)
        cell.hotelNameLabel.text = hotel.name
        cell.priceLabel.text = "\(hotel.price)\(hotel.currencyName)"
        cell.locationLabel.text = hotel.locationName
        cell.ratingBar.rating = hotel.stars!
        cell.setRate(Double(hotel.rating!))
        return cell
    }
}
